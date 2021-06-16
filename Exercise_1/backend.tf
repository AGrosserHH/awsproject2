terraform {
  backend "s3" {
    bucket = "udacity-aws-p2-terraform"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    access_key="AKIAT2CV7RVEFLEJUH4Q"
    secret_key="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"
  }
}