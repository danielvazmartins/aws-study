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