terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }


  }

  backend "azurerm" {
    resource_group_name  = "vinod_main_rg"
    storage_account_name = "vinodstoragemaina" 
    container_name       = "container22"         # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "manual.terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  subscription_id = "98473d5b-c639-404e-9bf2-91559fe65ff8"
}