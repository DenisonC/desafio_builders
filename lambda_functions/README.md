Para criar uma aplicação que execute uma tarefa sempre que um Security Group é criado ou modificado na sua conta AWS, você pode usar os recursos de eventos da AWS. Isso é possível usando o serviço Amazon CloudWatch Events para monitorar eventos de criação e modificação do Security Group.

A seguir, descrevemos os passos necessários para criar essa aplicação:

Utilize o bicket que foi criado na API em java descrito no passo 2:

Crie uma nova função do AWS Lambda para processar os eventos do CloudWatch. Para isso, vamos utilizar o Terraform.

Para criar uma função Lambda com o Terraform na AWS, você pode seguir os seguintes passos:
-------------------------

Entre no diretório lambda_functions e edite o arquivo main.tf:
```ruby
provider "aws" {
  region = "us-west-2" # substitua pela região desejada
}

resource "aws_lambda_function" "my_lambda_function" {
  filename         = "my_lambda_function.zip"
  function_name    = "my-lambda-function"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("my_lambda_function.zip")
  runtime          = "nodejs12.x"
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}
```
Neste arquivo, estamos definindo um provedor AWS, uma função Lambda chamada my-lambda-function e um papel IAM que a função usará. Também estamos anexando a política AWSLambdaBasicExecutionRole ao papel IAM para conceder permissões básicas de execução da função.


Selecione a opção "Autor do zero" e escolha uma linguagem de programação compatível para sua aplicação. Em seguida, defina as permissões de execução para a função Lambda.

Copie e cole o código de exemplo abaixo para o editor de código da função Lambda:



Este código extrai informações do evento do CloudWatch e cria um arquivo de texto com essas informações. Em seguida, faz o upload do arquivo criado para o bucket S3 que você criou no passo 1.

Configure o CloudWatch Events para acionar a função Lambda sempre que um Security Group for criado ou modificado. No console do CloudWatch, selecione "Eventos" no menu principal e clique em "Criar regra".

Na tela de configuração de regras do CloudWatch, defina as condições para acionar a função Lambda. Por exemplo, para acionar a função sempre que um Security Group for criado, configure a regra para "Criar SecurityGroup". Em seguida, selecione a função Lambda que você criou no passo 3 como o destino da regra.

Salve a regra do CloudWatch e teste a aplicação. Crie ou modifique um Security Group em sua conta AWS e verifique se o arquivo de texto com as informações sobre o evento foi criado e carregado com sucesso para o bucket S3.
