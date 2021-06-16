# https://github.com/maxgherman/udacity-aws-cloud-architect/blob/master/design-provision-monitor-aws-Infra-at-scale/Exercise_1/main.tf
# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key="xxx"
  secret_key="xxx"
  region = "eu-central-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-05f7491af5eef733a"
  instance_type = "t2.small"
  tags = {
    name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-05f7491af5eef733a"
  instance_type = "m4.large"
  tags = {
    name = "Udacity M4"
  }
}

