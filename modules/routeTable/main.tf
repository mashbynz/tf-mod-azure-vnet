resource "azurerm_route_table" "SSGatewayRT" {
  name                = var.GatewayRT_name
  location            = var.primarylocation
  resource_group_name = var.ssrg_name
}

resource "azurerm_route" "SSGatewayRoute" {
  name                   = var.route_name
  resource_group_name    = azurerm_route_table.SSGatewayRT.resource_group_name
  route_table_name       = azurerm_route_table.SSGatewayRT.name
  address_prefix         = var.GatewayRT_prefix
  next_hop_type          = var.GatewayRT_nexthoptype
  next_hop_in_ip_address = var.GatewayRT_nexthopIP
}
