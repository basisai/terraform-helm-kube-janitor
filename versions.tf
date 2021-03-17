terraform {
  required_version = ">= 0.13"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}