# Resource Group

resource "azurerm_resource_group" "default" {
  count    = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name     = "${module.rg_label.id}${var.delimiter}${element(keys(var.vpc_config.location), count.index)}${var.delimiter}${module.vnet_label.attributes}"
  location = element(values(var.vpc_config), count.index)
  tags     = module.rg_label.tags
}

# VNet

resource "azurerm_virtual_network" "default" {
  count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                = "${module.vnet_label.id}${var.delimiter}${element(keys(var.vpc_config.location), count.index)}${var.delimiter}${module.vnet_label.attributes}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  address_space       = element(values(var.vpc_config.address_space), count.index)
  tags                = module.vnet_label.tags

  # ddos_protection_plan {
  #   id     = azurerm_network_ddos_protection_plan.default.id
  #   enable = true
  # }
}

# NSG

resource "azurerm_network_security_group" "default" {
  count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                = "${module.nsg_label.id}${var.delimiter}${element(keys(var.vpc_config.location), count.index)}${var.delimiter}${module.nsg_label.attributes}"
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
  count                = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                 = module.gateway_subnet_label.id
  resource_group_name  = azurerm_resource_group.default.*.name[count.index]
  virtual_network_name = azurerm_virtual_network.default.*.name[count.index]
  address_prefix       = element(values(var.vpc_config.gateway_prefix), count.index)
}

resource "azurerm_subnet" "firewall" {
  count                = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.default.*.name[count.index]
  virtual_network_name = azurerm_virtual_network.default.*.name[count.index]
  address_prefix       = element(values(var.vpc_config.gateway_prefix), count.index)
}

# Route Table

resource "azurerm_route_table" "default" {
  count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                = "${module.rt_label.id}${var.delimiter}${element(keys(var.vpc_config.location), count.index)}${var.delimiter}${module.rt_label.attributes}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  tags                = module.rt_label.tags
}

resource "azurerm_route" "default" {
  count                  = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                   = module.route_label.id
  resource_group_name    = azurerm_resource_group.default.*.name[count.index]
  route_table_name       = azurerm_route_table.default.*.name[count.index]
  address_prefix         = var.vpc_config.gateway_rt_prefix
  next_hop_type          = var.vpc_config.gateway_rt_nexthop_type
  next_hop_in_ip_address = element(values(var.vpc_config.gateway_rt_nexthop_ip), count.index)

}

resource "azurerm_subnet_route_table_association" "default" {
  count          = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  subnet_id      = azurerm_subnet.gateway.id
  route_table_id = azurerm_route_table.default.id
}

# Azure Firewall

resource "azurerm_public_ip" "FirewallPIP" {
  count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                = "${module.fw_pip_label.id}${var.delimiter}${element(keys(var.vpc_config.location), count.index)}${var.delimiter}${module.fw_pip_label.attributes}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  allocation_method   = var.vpc_config.firewall_allocation_method
  sku                 = var.vpc_config.firewall_sku
  tags                = module.fw_pip_label.tags
}

resource "azurerm_firewall" "default" {
  count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
  name                = "${module.firewall_label.id}${var.delimiter}${element(keys(var.vpc_config.location), count.index)}${var.delimiter}${module.firewall_label.attributes}"
  location            = azurerm_resource_group.default.*.location[count.index]
  resource_group_name = azurerm_resource_group.default.*.name[count.index]
  tags                = module.firewall_label.tags

  ip_configuration {
    name                 = module.ipconfig_label.id
    subnet_id            = azurerm_subnet.firewall.*.id[count.index]
    public_ip_address_id = azurerm_public_ip.FirewallPIP.*.id[count.index]
  }
}

# # VPN Gateway

# resource "azurerm_public_ip" "GatewayPIP" {
#   count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
#   name                = module.vgw_pip_label.id
#   location            = var.region
#   resource_group_name = azurerm_resource_group.default.name
#   allocation_method   = var.vpngw_allocation_method
#   sku                 = var.vpngw_ip_sku
#   tags                = module.vgw_pip_label.tags
# }

# resource "azurerm_virtual_network_gateway" "default" {
#   count               = var.enabled == true ? length(keys(var.vpc_config.location)) : 0
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
