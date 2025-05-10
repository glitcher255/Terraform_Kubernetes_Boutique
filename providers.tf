# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27.0"
    }
  }
  required_version = ">= 1.1.0"

  #backend
backend "remote" {
  organization = "Glitcher255_tf"

  workspaces { 
    name = "Terraform_Flame_App"
  }
}
}

#Microsoft Azure provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}