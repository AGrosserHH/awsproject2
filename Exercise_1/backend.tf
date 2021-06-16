terraform {
  backend "s3" {
    bucket = "udacity-aws-p2-terraform"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    access_key="xxx"
    secret_key="xxx"
  }
}
