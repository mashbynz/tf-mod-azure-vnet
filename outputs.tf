output "rg_name" {
  value = azurerm_resource_group.default.name
}

output "vnet_id" {
  value = azurerm_virtual_network.default.id
}
