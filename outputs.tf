output "rg_name" {
  value = list(azurerm_resource_group.default.*.name)
}

output "rg_id" {
  value = list(azurerm_resource_group.default.*.id)
}

output "rg_location" {
  value = list(azurerm_resource_group.default.*.location)
}

output "vnet_id" {
  value = list(azurerm_virtual_network.default.*.id)
}

output "gateway_subnet_id" {
  value = list(azurerm_subnet.gateway.*.id)
}
