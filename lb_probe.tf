resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "tcpProbe"
  protocol        = "Tcp"
  port            = 80
}
