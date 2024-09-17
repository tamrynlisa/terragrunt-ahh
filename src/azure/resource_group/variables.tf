variable "base_name" {
    description = "The base name for resources."
    type = string
}

variable "default_separator" {
    description = "The default separator to use for naming resources."
    type = string
}

variable "region" {
    description = "The region in which to work."
    type = string
}

variable "tags" {
    description = "The tags to apply to resources."
    type = map(any)
}

variable "name" {
    description = "The name for the resource group. Leave empty to use the default."
    type = string
    default = ""
}

locals {
    rg_name = var.name == "" ? var.base_name : var.name
}
