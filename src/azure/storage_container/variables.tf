variable "name" {
  description = "The name of the storage container."
  type = string
  default = "tfstate"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type = string
  default = "stterragruntexercise"
}

variable "container_access_type" {
  description = "The container access type of the storage container."
  type = string
  default = "Private"
}