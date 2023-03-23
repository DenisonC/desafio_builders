Para utilizar uma imagem Docker no Amazon Elastic Container Registry (ECR) com o Amazon ECS Fargate e Terraform, você pode seguir os seguintes passos:

1 - Vamos criar um repositório no ECR para armazenar a imagem Docker. Para fazer isso, usaremos o seguinte recurso ao seu arquivo main.tf:
-----------------------------------
```ruby
resource "aws_ecr_repository" "my_repo" {
  name = "my-repo"
}
```

2 - Construindo sua imagem Docker e fazendo o push para o ECR:
-------------------------------------
```
# faça login no ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.us-east-1.amazonaws.com

# construa sua imagem Docker, entre no diretório 01-describe_create_delete_sg onde contém o Dokerfile com as configurações que serão editadas no passo a passo da documentação
docker build -t my-image .

# tag da imagem
docker tag my-image:latest <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/my-repo:latest

# push da imagem para o ECR
docker push <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/my-repo:latest
```
