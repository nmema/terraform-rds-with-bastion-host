provider "aws" {
  region = var.aws_region
}

provider "http" {}

provider "tls" {}

provider "local" {}
