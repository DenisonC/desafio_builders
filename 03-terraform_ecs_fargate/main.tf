resource "aws_ecr_repository" "my_repo" {
  name = "my-repo"
}
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
