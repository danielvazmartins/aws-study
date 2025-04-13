resource "aws_ecs_cluster" "tf-cluster" {
    name = "tf-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "fargate_provider" {
    cluster_name = aws_ecs_cluster.tf-cluster.name
    capacity_providers = [ "FARGATE" ]
}

resource "aws_iam_role" "ecs_execution_role" {
    name = "ecs-execution-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_policy" "ecs_cloudwatch_policy" {
    name = "ecs-cloudwatch-policy"
    description = "Permissão para o ECS enviar logs para o CloudWatch"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ]
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_policy" "ecs_ecr_policy" {
    name = "ecs-ecr-policy"
    description = "Permissão para baixar as imagens"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "ecr:GetAuthorizationToken",
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:GetDownloadUrlForLayer",
                    "ecr:BatchGetImage",
                ]
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_logs" {
    role = aws_iam_role.ecs_execution_role.name
    policy_arn = aws_iam_policy.ecs_cloudwatch_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_ecr" {
    role = aws_iam_role.ecs_execution_role.name
    policy_arn = aws_iam_policy.ecs_ecr_policy.arn
}

resource "aws_cloudwatch_log_group" "ecs-logs" {
    name = "/ecs/bff-container"
}

resource "aws_security_group" "ecs_bff_sg" {
    vpc_id = var.vpc_id
    
    ingress {
        from_port = var.container_port
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = var.container_port
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    
    # Porta necessária para baixar a imagem do DockerHub
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    } 
}

resource "aws_ecs_task_definition" "tf-task-definition" {
    family = "tf-bff-task"
    requires_compatibilities = [ "FARGATE" ]
    cpu = "512"
    memory = "1024"
    network_mode = "awsvpc"
    execution_role_arn = aws_iam_role.ecs_execution_role.arn

    container_definitions = jsonencode([
        {
            name = "bff-container"
            image = var.container_image
            cpu = 512
            memory = 1024
            essential = true
            portMappings = [
                {
                    containerPort = var.container_port
                    hostPort = var.host_port
                    protocol = "tcp"
                }
            ]
            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    awslogs-region = "us-east-1"
                    awslogs-group = "/ecs/bff-container"
                    awslogs-create-group = "true"
                    awslogs-stream-prefix = "ecs"
                }
            }
        }
    ])
}

resource "aws_ecs_service" "tf-ecs-service" {
    name = "tf-ecs-service"
    cluster = aws_ecs_cluster.tf-cluster.id
    task_definition = aws_ecs_task_definition.tf-task-definition.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = var.subnets
        security_groups = [ aws_security_group.ecs_bff_sg.id ]
        assign_public_ip = true
    }
}