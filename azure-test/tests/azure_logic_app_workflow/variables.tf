variable "resource_name" {
  type        = string
  default     = "steampipe-test"
  description = "Name of the resource used throughout the test."
}

variable "azure_environment" {
  type        = string
  default     = "public"
  description = "Azure environment used for the test."
}

variable "azure_subscription" {
  type        = string
  default     = "cdffd708-7da0-4cea-abeb-0a4c334d7f64"
  description = "Azure subscription used for the test."
}

provider "azurerm" {
  # Cannot be passed as a variable
  environment     = var.azure_environment
  subscription_id = var.azure_subscription
  features {}
}

data "azurerm_client_config" "current" {}

data "null_data_source" "resource" {
  inputs = {
    scope = "azure:///subscriptions/${data.azurerm_client_config.current.subscription_id}"
  }
}

resource "azurerm_resource_group" "named_test_resource" {
  name     = var.resource_name
  location = "East US"
}

resource "azurerm_logic_app_workflow" "named_test_resource" {
  name                = var.resource_name
  location            = azurerm_resource_group.named_test_resource.location
  resource_group_name = azurerm_resource_group.named_test_resource.name
}

output "resource_aka" {
  value = "azure://${azurerm_logic_app_workflow.named_test_resource.id}"
}

output "resource_aka_lower" {
  value = "azure://${lower(azurerm_logic_app_workflow.named_test_resource.id)}"
}

output "resource_name" {
  value = var.resource_name
}

output "resource_id" {
  value = azurerm_logic_app_workflow.named_test_resource.id
}

output "location" {
  value = azurerm_logic_app_workflow.named_test_resource.location
}

output "subscription_id" {
  value = var.azure_subscription
}
