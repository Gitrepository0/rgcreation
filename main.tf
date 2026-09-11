# Create a resource group
resource "azurerm_resource_group" "myrg" {  
  name = var.rgvar.name
  location = var.rgvar.location
}

