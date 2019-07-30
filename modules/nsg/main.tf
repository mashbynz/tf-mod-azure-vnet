resource "azurerm_network_security_group" "gatewayNSG" {
  name                = var.gatewaynsg_name
  location            = var.primarylocation
  resource_group_name = var.ssrg_name
}
