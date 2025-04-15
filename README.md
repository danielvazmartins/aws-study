# aws-study
Repositório criado com o intuito de estudar os serviços da AWS

# Comandos Terraform
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy

# Comandos Docker
docker build -t aws-ecs-front .
docker run -d -p 8080:80 aws-ecs-front
docker ps
docker stop CONTAINER_ID

# Comando AWS
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 940482411315.dkr.ecr.us-east-1.amazonaws.com
aws erc create-repository --repository-name ${app-name}
docker tag aws-ecs-front:latest 940482411315.dkr.ecr.us-east-1.amazonaws.com/nginx-app:latest
docker push 940482411315.dkr.ecr.us-east-1.amazonaws.com/nginx-app:latest
aws ecr delete-repository --repository-name nginx-app --force