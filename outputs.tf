output "ssrg_name" {
  value = azurerm_resource_group.SharedServicesRG.name
}

output "ssvnet_name" {
  value = azurerm_virtual_network.SharedServicesVNet.name
}

output "ssvnet_addressspace" {
  value = azurerm_virtual_network.SharedServicesVNet.address_space
}

output "ssvnetddos_name" {
  value = azurerm_ddos_protection_plan.SharedServicesDDoS.name
}

output "gatewaynsg_name" {
  value = azurerm_network_security_group.gatewayNSG.name
}

output "gatewaysubnet_name" {
  value = azurerm_subnet.SSGatewaySubnet.name
}

output "gatewaysubnet_prefix" {
  value = azurerm_subnet.SSGatewaySubnet.address_prefix
}

output "firewallsubnet_name" {
  value = azurerm_subnet.SSFirewallSubnet.name
}

output "firewallsubnet_prefix" {
  value = azurerm_subnet.SSFirewallSubnet.address_prefix
}

output "GatewayRT_name" {
  value = azurerm_route_table.SSGatewayRT.name
}

output "GatewayRT_prefix" {
  value = azurerm_route.SSGatewayRoute.address_prefix
}

output "GatewayRT_nexthopIP" {
  value = azurerm_route.SSGatewayRoute.next_hop_in_ip_address
}
