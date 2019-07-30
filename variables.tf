# var.ssrg_name = "prodsharedservices-rg"
# var.primarylocation = "australiaeast"
# var.ssvnet_name = "prodsharedservces-vnet"
# var.ssvnet_addressspace = ["10.48.0.0/16"]
# var.ssvnetddos_name = "prodsharedservices-ddos"
# var.gatewaynsg_name = "prodsharedservicesgw-nsg"
# var.gatewaysubnet_name = "GatewaySubnet"
# var.gatewaysubnet_prefix = "10.48.0.0/27"
# var.firewallsubnet_name = "AzureFirewallSubnet"
# var.firewallsubnet_prefix = "10.48.1.0/24"
# var.GatewayRT_name = "prodsharedservicesgw-rt"
# var.GatewayRT_prefix = "0.0.0.0/0"
# var.GatewayRT_nexthoptype = "VirtualAppliance"
# var.GatewayRT_nexthopIP = "10.48.1.4"

/*****
VNET Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
@Matt Ashby To Fill In
*****/

variable "vnet_name" {
  type        = string
  description = ""
  default     = ""
}

variable "vnet_addressspace" {
  type        = list(string)
  description = ""
  default     = []
}

variable "vnet_ddos_name" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_nsg_name" {
  type        = string
  description = ""
  default     = ""
}
variable "gateway_subnet_name" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_subnet_name" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_name" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_nexthop_type" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_nexthop_ip" {
  type        = string
  description = ""
  default     = ""
}

