resource "aws_lambda_function" "lambda" {
    filename      = "${var.lambda_funct_name}.zip"
    function_name = "${var.name}_${var.handler}"
    role          = "${aws_iam_role.iam_role_for_lambda.iam_role_for_lambda.arn}"
    handler       = "${var.app_name}.${var.handler}"
    runtime       = "python3.7"
}
resource "aws_iam_role" "iam_role_for_lambda" {
  name = "iam_role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com",
        "Service": "apigateway.amazonaws.com",
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}