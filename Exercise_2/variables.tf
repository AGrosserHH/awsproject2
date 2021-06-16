# TODO: Define the variable for aws_region
variable "function_name" {
  default = "greet_lambda"
}

variable "lambda_handler" {
  default = "greet_lambda.lambda_handler"
}

variable "runtime" {
  default = "python3.7"
}

