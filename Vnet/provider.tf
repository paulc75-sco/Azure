terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.7.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "0f1dffc2-a6e4-4e2b-82df-1ebf36770e60"
  features {
  }
}
