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
