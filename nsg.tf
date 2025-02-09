resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
        name                        = "allow-http"
        priority                    = 100
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "80"
        source_address_prefix       = "*"
        destination_address_prefix  = "10.0.1.0/24"  # Update with the address prefix of your subnet
    }

}
