#https://gist.github.com/smithclay/e026b10980214cbe95600b82f67b4958

provider "aws" {
  access_key="AKIAT2CV7RVEFLEJUH4Q"
  secret_key="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"
  region = "eu-central-1"
}

resource "aws_lambda_function" "greet_lambda" {
  #role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = var.lambda_handler
  runtime          = "${var.runtime}"
  filename         = "greet_lambda.zip"
  function_name    = "${var.function_name}"  
  #depends_on    = ["aws_cloudwatch_log_group.lambda_logging"]
  # each lambda function must have an IAM role
  role          = "${aws_iam_role.lambda_role.arn}"
  # if you want to specify the retention period of the logs you need this
  depends_on    = [aws_cloudwatch_log_group.lambda_logging]

  environment {
    variables = {
      greeting = "Hi there!"
    }
  }
}

# This defines the minimum (maybe only?) IAM policy for a lambda's role.
# Do not try to add permissions for logging directly in to it because it
# won't work.
data "aws_iam_policy_document" "lambda_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_role.json}"
}

# This defines the IAM policy needed for a lambda to log. #1
# This defines the IAM policy needed for a lambda to log. #1
data "aws_iam_policy_document" "lambda_logging" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

# This creates the policy needed for a lambda to log. #2
resource "aws_iam_policy" "lambda_logging" {
  name   = "example-lambda-logging"
  path   = "/"
  policy = "${data.aws_iam_policy_document.lambda_logging.json}"
}

# This attaches the policy needed for logging to the lambda's IAM role. #3
resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}

resource "aws_cloudwatch_log_group" "lambda_logging" {
  name              = "/aws/lambda/example-lambda-function"
  retention_in_days = 5
}
