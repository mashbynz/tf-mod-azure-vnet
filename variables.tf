/*****
Common Variables: Azure provider - Autoloaded from Terragrunt.
*****/

variable "region" {
  description = "The Azure region (e.g. 'australiaeast'). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

variable "enabled" {
  type        = bool
  description = "switch if this resource is to be created or not"
  default     = true
}

/*****
VNET Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "rg_name" {
  type        = string
  description = ""
  default     = ""
}

variable "rg_location" {
  type        = string
  description = ""
  default     = ""
}

variable "vpc_config" {
  type = object({
    location = map(string)
    enabled  = bool
    address_space = object({
      ae  = list(string)
      ase = list(string)
    })
    gateway_prefix             = map(string)
    firewall_prefix            = map(string)
    firewall_allocation_method = string
    firewall_sku               = string
    vpngw_allocation_method    = string
    vpngw_type                 = string
    vpngw_sku                  = string
    vpngw_ip_sku               = string
    vpngw_private_allocation   = string
    client_address             = map(string)
    vpn_client_protocol        = list(string)
    # gateway_rt_prefix          = string
    # gateway_rt_nexthop_type    = string
    # gateway_rt_nexthop_ip = map(string)
  })

  default = {
    location = {}
    enabled  = true
    address_space = {
      ae  = []
      ase = []
    }
    gateway_prefix             = {}
    firewall_prefix            = {}
    firewall_allocation_method = null
    firewall_sku               = null
    vpngw_allocation_method    = null
    vpngw_type                 = null
    vpngw_sku                  = null
    vpngw_ip_sku               = null
    vpngw_private_allocation   = null
    client_address             = {}
    vpn_client_protocol        = []
    gateway_rt_prefix          = null
    gateway_rt_nexthop_type    = null
    gateway_rt_nexthop_ip      = {}
  }
  description = "Default VNET configuration"
}

/*****
Label Module Variables
*****/

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "sharedservices_name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "class" {
  type        = string
  default     = ""
  description = "the type of resource e.g. 'sharedservices' or 'app1'"
}

variable "delimiter" {
  type        = string
  default     = ""
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "context" {
  type = object({
    namespace           = string
    environment         = string
    stage               = string
    name                = string
    enabled             = bool
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
  })
  default = {
    namespace           = ""
    environment         = ""
    stage               = ""
    name                = ""
    enabled             = true
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = ""
  }
  description = "Default context to use for passing state between label invocations"
}
