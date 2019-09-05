# Resource Group

resource "azurerm_resource_group" "default" {
  count    = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name     = "${element(keys(var.vnet_config.location), count.index)}${var.sharedservices_name}${module.rg_label.delimiter}${element(module.rg_label.attributes, 0)}${length(keys(var.vnet_config.location), 0)}"
  location = element(values(var.vnet_config.location), count.index)
  tags     = module.rg_label.tags
}

# VNet

resource "azurerm_virtual_network" "default" {
  count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                = "${module.vnet_label.id}${module.vnet_label.delimiter}${element(keys(var.vnet_config.location), count.index)}${module.vnet_label.delimiter}${element(module.vnet_label.attributes, 0)}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  address_space       = element(values(var.vnet_config.address_space), count.index)
  tags                = module.vnet_label.tags

  # ddos_protection_plan {
  #   id     = azurerm_network_ddos_protection_plan.default.id
  #   enable = true
  # }
}

# NSG

resource "azurerm_network_security_group" "default" {
  count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                = "${module.nsg_label.id}${module.nsg_label.delimiter}${element(keys(var.vnet_config.location), count.index)}${module.nsg_label.delimiter}${element(module.nsg_label.attributes, 0)}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  tags                = module.nsg_label.tags
}

# DDoS

# resource "azurerm_network_ddos_protection_plan" "default" {
#   name                = module.ddos_label.id
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name
#   tags                = module.ddos_label.tags
# }

# Subnets

resource "azurerm_subnet" "gateway" {
  count                = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                 = module.gateway_subnet_label.id
  resource_group_name  = azurerm_resource_group.default.*.name[count.index]
  virtual_network_name = azurerm_virtual_network.default.*.name[count.index]
  address_prefix       = element(values(var.vnet_config.gateway_prefix), count.index)
}

resource "azurerm_subnet" "firewall" {
  count                = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.default.*.name[count.index]
  virtual_network_name = azurerm_virtual_network.default.*.name[count.index]
  address_prefix       = element(values(var.vnet_config.firewall_prefix), count.index)
}

# Route Table

resource "azurerm_route_table" "default" {
  count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                = "${module.rt_label.id}${module.rt_label.delimiter}${element(keys(var.vnet_config.location), count.index)}${module.rt_label.delimiter}${element(module.rt_label.attributes, 0)}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  tags                = module.rt_label.tags
}

resource "azurerm_route" "default" {
  count                  = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                   = module.route_label.id
  resource_group_name    = azurerm_resource_group.default.*.name[count.index]
  route_table_name       = azurerm_route_table.default.*.name[count.index]
  address_prefix         = element(values(var.vnet_config.rt_prefix), count.index)
  next_hop_type          = element(values(var.vnet_config.rt_nexthop_type), count.index)
  next_hop_in_ip_address = element(values(var.vnet_config.rt_nexthop_ip), count.index)

}

resource "azurerm_subnet_route_table_association" "default" {
  count          = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  subnet_id      = azurerm_subnet.gateway.*.id[count.index]
  route_table_id = azurerm_route_table.default.*.id[count.index]
}

# Azure Firewall

resource "azurerm_public_ip" "FirewallPIP" {
  count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  name                = "${module.fw_pip_label.id}${module.fw_pip_label.delimiter}${element(keys(var.vnet_config.location), count.index)}${module.fw_pip_label.delimiter}${element(module.fw_pip_label.attributes, 0)}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  allocation_method   = var.vnet_config.firewall_allocation_method
  sku                 = var.vnet_config.firewall_sku
  tags                = module.fw_pip_label.tags
}

resource "azurerm_firewall" "default" {
  count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
  # name                = "${module.firewall_label.id}${module.firewall_label.delimiter}${element(keys(var.vnet_config.location), count.index)}${module.firewall_label.delimiter}${element(module.firewall_label.attributes, 0)}"
  name                = "${element(keys(var.vnet_config.location), count.index)}${module.firewall_label.delimiter}${element(module.firewall_label.attributes, 0)}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  tags                = module.firewall_label.tags

  ip_configuration {
    name                 = module.ipconfig_label.id
    subnet_id            = azurerm_subnet.firewall.*.id[count.index]
    public_ip_address_id = azurerm_public_ip.FirewallPIP.*.id[count.index]
  }
}

# VPN Gateway

# resource "azurerm_public_ip" "GatewayPIP" {
#   count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
#   name                = "${module.vgw_pip_label.id}${module.vgw_pip_label.delimiter}${element(keys(var.vnet_config.location), count.index)}${module.vgw_pip_label.delimiter}${element(module.vgw_pip_label.attributes, 0)}"
#   location            = azurerm_resource_group.default.*.location[count.index]
#   resource_group_name = azurerm_resource_group.default.*.name[count.index]
#   allocation_method   = var.vnet_config.vpngw_allocation_method
#   sku                 = var.vnet_config.vpngw_ip_sku
#   tags                = module.vgw_pip_label.tags
# }

# resource "azurerm_virtual_network_gateway" "default" {
#   count               = var.vnet_enabled == true ? length(keys(var.vnet_config.location)) : 0
#   name                = module.vgw_label.id
#   location            = var.region
#   resource_group_name = azurerm_public_ip.GatewayPIP.resource_group_name
#   tags                = module.vgw_label.tags

#   type     = var.vpngw_type
#   vpn_type = var.vpngw_vpn_type

#   active_active = false
#   enable_bgp    = false
#   sku           = var.vpngw_sku

#   ip_configuration {
#     name                          = module.ipconfig_label.id
#     public_ip_address_id          = azurerm_public_ip.GatewayPIP.id
#     private_ip_address_allocation = var.vpngw_private_alloc
#     subnet_id                     = azurerm_subnet.gateway.id
#   }

#   vpn_client_configuration {
#     address_space        = var.vpngw_client_address
#     vpn_client_protocols = var.vpn_client_protocols
#   }
# }
