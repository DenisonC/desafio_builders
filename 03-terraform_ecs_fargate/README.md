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
 3 - O seguinte recurso no arquivo main.tf vai definir uma definição de tarefa (task definition) que usa sua imagem Docker no ECR:
 -----------------------------
 ```ruby
 resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task"
  container_definitions    = jsonencode([{
    name            = "my-container"
    image           = "${aws_ecr_repository.my_repo.repository_url}:latest"
    cpu             = 256
    memory          = 512
    port_mappings   = [
      {
        container_port = 80
        host_port      = 80
      },
    ]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}
```
Observe que estamos usando a URL do repositório ECR, que pode ser obtida usando a expressão ${aws_ecr_repository.my_repo.repository_url}.

4 - O seguinte recurso serve para definir um serviço (service) que usa sua definição de tarefa (task definition) acima:
----------------------------
```ruby
resource "aws_ecs_service" "my_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1

  network_configuration {
    subnets         = ["subnet-abc123", "subnet-def456"]
    security_groups = ["sg-xyz789"]
  }
}
```

5 - Finalmente, execute terraform plan e terraform apply para criar seu cluster ECS Fargate, sua definição de tarefa e seu serviço.
-----------------
```
terraform plan
```

```
terraform apply
```

Para excluir toda a infraestrutura criada execute:
```
terraform destroy
```
