# Create a resource group
resource "azurerm_resource_group" "myrg" {
  name     = var.rgvar.name
  location = var.rgvar.location
}

# Create a Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnetvar.name
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = [var.vnetvar.address_space]
}

# Create a Subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = var.subnetvar.name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = [var.subnetvar.address_prefixes]
}

# Create a Public IP
resource "azurerm_public_ip" "mypublicip" {
  name                = "${var.vmvar.name}-pip"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
}

# Create a Network Interface
resource "azurerm_network_interface" "mynic" {
  name                = "${var.vmvar.name}-nic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id
  }
}

# Create a Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "myvm" {
  name                            = var.vmvar.name
  location                        = azurerm_resource_group.myrg.location
  resource_group_name             = azurerm_resource_group.myrg.name
  size                            = var.vmvar.size
  admin_username                  = var.vmvar.admin_username
  admin_password                  = var.vmvar.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.mynic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vmvar.os_disk_type
  }

  source_image_reference {
    publisher = var.vmvar.publisher
    offer     = var.vmvar.offer
    sku       = var.vmvar.sku
    version   = var.vmvar.image_version
  }
}

