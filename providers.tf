terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.48.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.31.0"
    }
  }
}
