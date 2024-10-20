variable "id" {
  description = "The storage account ID."
  type        = string
  default     = "/subscriptions/d4aed6b4-8573-4645-b7a3-3cf34177e822/resourceGroups/rg-default-infra-tfstate/providers/Microsoft.Storage/storageAccounts/stterragruntexercise"
}

variable "name" {
  description = "The name of the storage account."
  type        = string
  default     = "stterragruntexercise"
}

variable "account_tier" {
  description = "The account tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The account replication type of the storage account."
  type        = string
  default     = "RAGRS"
}

variable "rg" {
  description = "The resource group that the storage account is in."
  type        = string
  default     = "rg-default-infra-tfstate"
}

variable "location" {
  description = "The location of the storage account."
  type        = string
  default     = "South Africa North"
}

# variable "rg_location" {
#   description = "The location of the resource group that the storage account is in."
#   type        = string
#   default     = "South Africa North"
# }