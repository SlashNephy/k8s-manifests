terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    mackerel = {
      source  = "mackerelio-labs/mackerel"
      version = "~> 0.3"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "mackerel" {
  api_key = var.mackerel_api_key
}
