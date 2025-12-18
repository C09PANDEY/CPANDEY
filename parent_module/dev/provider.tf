
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "aks-rg"
    storage_account_name = "lalli2211"
    container_name = "lalli"
    key = "day2-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a46e2f32-e4a1-44bf-946c-f3fa4a273aa1"
}