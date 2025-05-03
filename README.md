# aws-study
Repositório criado com o intuito de estudar os serviços da AWS

# Comandos Terraform
```powershell
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
terraform show

## Habilitar debug (Powershell)
$env:TF_LOG="DEBUG"
Remove-Item Env:\TF_LOG
```

# Comandos Docker
```powershell
docker build -t aws-ecs-front .
docker run -d -p 8080:80 aws-ecs-front
docker ps
docker stop CONTAINER_ID
```

# Comando AWS
```powershell
# ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 940482411315.dkr.ecr.us-east-1.amazonaws.com
aws erc create-repository --repository-name ${app-name}
docker tag aws-ecs-front:latest 940482411315.dkr.ecr.us-east-1.amazonaws.com/nginx-app:latest
docker push 940482411315.dkr.ecr.us-east-1.amazonaws.com/nginx-app:latest
aws ecr delete-repository --repository-name nginx-app --force

# IAM
aws sts get-caller-identity
aws iam simulate-principal-policy --policy-source-arn arn:aws:iam::940482411315:user/terraform --action-names glue:CreateJob
```

# Referências do GitHub Actions....
- https://github.com/actions/checkout
- https://github.com/marketplace/actions/create-pull-request