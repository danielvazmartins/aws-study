# Configurações de rede
variable "vpc_id" {
    description = "ID da VPC default na AWS"
    type = string
}

variable "subnets" {
    description = "IDs das subnets para subir as tasks"
    type = list(string)
}

# Configurações do container
variable "container_image" {
    description = "Imagem utilizada pelo container"
    type = string
}

variable "host_port" {
    description = "Porta utilizada pela imagem do container"
    type = number
}

variable "container_port" {
    description = "Porta utilizada pelo container"
    type = number
}