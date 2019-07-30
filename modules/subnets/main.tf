resource "azurerm_subnet" "SSGatewaySubnet" {
  name                 = var.gatewaysubnet_name
  resource_group_name  = var.ssrg_name
  virtual_network_name = var.ssvnet_name
  address_prefix       = var.gatewaysubnet_prefix
}

resource "azurerm_subnet" "SSFirewallSubnet" {
  name                 = var.firewallsubnet_name
  resource_group_name  = var.ssrg_name
  virtual_network_name = var.ssvnet_name
  address_prefix       = var.firewallsubnet_prefix
}
