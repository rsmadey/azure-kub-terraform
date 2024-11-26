
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "api-rg" {
  name     = "APIResourceGroup"
  location = "westus2"
}

resource "azurerm_kubernetes_cluster" "python-api-cluster" {
  name                = "py-api-aks"
  location            = azurerm_resource_group.api-rg.location
  resource_group_name = azurerm_resource_group.api-rg.name

  dns_prefix = "py-api"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

}
terraform { 
  cloud { 
    
    organization = "madey" 

    workspaces { 
      name = "azkub" 
    } 
  } 
}