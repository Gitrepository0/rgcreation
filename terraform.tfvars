    rgvar = {
      name     = "AzureRG"
      location = "Central India"
    }

    vnetvar = {
      name          = "myVNet"
      address_space = "10.0.0.0/16"
    }

    subnetvar = {
      name             = "mySubnet"
      address_prefixes = "10.0.1.0/24"
    }

    vmvar = {
      name           = "myVM"
      size           = "Standard_B1s"
      admin_username = "azureuser"
      admin_password = "P@ssw0rd1234!"
      os_disk_type   = "Standard_LRS"
      publisher      = "Canonical"
      offer          = "0001-com-ubuntu-server-jammy"
      sku            = "22_04-lts"
      image_version  = "latest"
    }




    
