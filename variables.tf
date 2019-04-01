variable "aws_vpc_name" {}
variable "aws_region" {}
variable "aws_instance_type" {}
variable "aws_key_name" {}

variable "aws_vpc_cidr" {}

variable "aws_subnet_cidr" {
  type = "list"
}

variable "aws_subnet_AZ" {
  type = "list"
}

variable "aws_ami_id" {
  type = "map"

  default = {
    us-east-1      = "ami-0080e4c5bc078760e"
    us-east-2      = "ami-0cd3dfa4e37921605"
    us-west-1      = "ami-0ec6517f6edbf8044"
    us-west-2      = "ami-01e24be29428c15b2"
    ap-south-1     = "ami-0ad42f4f66f6c1cc9"
    ap-northeast-2 = "ami-00dc207f8ba6dc919"
    ap-southeast-1 = "ami-05b3bcf7f311194b3"
    ap-southeast-2 = "ami-02fd0b06f06d93dfc"
    ap-northeast-1 = "ami-00a5245b4816c38e6"
    eu-west-1      = "ami-08935252a36e25f85"
    eu-west-2      = "ami-01419b804382064e4"
    eu-west-3      = "ami-0dd7e7ed60da8fb83"
    eu-north-1     = "ami-86fe70f8"
    sa-east-1      = "ami-05145e0b28ad8e0b2"
    ca-central-1   = "ami-07423fb63ea0a0930"
    eu-central-1   = "ami-0cfbf4f6db41068ac"
  }
}
