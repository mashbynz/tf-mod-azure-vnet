output "rg_name" {
  value = azurerm_resource_group.default.*.name
}

output "rg_id" {
  value = azurerm_resource_group.default.*.id
}

output "rg_location" {
  value = azurerm_resource_group.default.*.location
}

output "vnet_id" {
  value = azurerm_virtual_network.default.*.id
}

output "gateway_subnet_id" {
  value = sazurerm_subnet.gateway.*.id
}
