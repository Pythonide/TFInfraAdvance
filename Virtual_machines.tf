resource "azurerm_windows_virtual_machine" "vm" {
  count               = 2
  name                = "vm${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  availability_set_id = azurerm_availability_set.avset.id
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "vm_extension" {
  count               = 2
  name                = "IIS-Extension-${count.index}"
  virtual_machine_id  = azurerm_windows_virtual_machine.vm[count.index].id
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
  {
      "commandToExecute": "powershell Add-WindowsFeature Web-Server"
  }
  SETTINGS
}