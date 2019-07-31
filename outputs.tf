output "ss_rg_name" {
  value = azurerm_resource_group.default.name
}

output "ss_rg_location" {
  value = azurerm_resource_group.default.location
}

# output "ssvnet_name" {
#   value = azurerm_virtual_network.default.name
# }

# output "ssvnet_addressspace" {
#   value = azurerm_virtual_network.default.address_space
# }

# output "ssvnetddos_name" {
#   value = azurerm_ddos_protection_plan.default.name
# }

# output "gatewaynsg_name" {
#   value = azurerm_network_security_group.default.name
# }

# output "gatewaysubnet_name" {
#   value = azurerm_subnet.gateway.name
# }

# output "gatewaysubnet_prefix" {
#   value = azurerm_subnet.default.address_prefix
# }

# output "firewallsubnet_name" {
#   value = azurerm_subnet.default.name
# }

# output "firewallsubnet_prefix" {
#   value = azurerm_subnet.default.address_prefix
# }

# output "GatewayRT_name" {
#   value = azurerm_route_table.default.name
# }

# output "GatewayRT_prefix" {
#   value = azurerm_route.default.address_prefix
# }

# output "GatewayRT_nexthopIP" {
#   value = azurerm_route.default.next_hop_in_ip_address
# }
