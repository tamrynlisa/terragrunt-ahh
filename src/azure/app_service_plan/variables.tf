variable "id" {
  description = "The app service plan ID."
  type        = string
  default     = "/subscriptions/d4aed6b4-8573-4645-b7a3-3cf34177e822/resourceGroups/rg-default-infra-tfstate/providers/Microsoft.Web/serverFarms/asp-linux-webapp"
  sensitive   = true
}

variable "name" {
  description = "The name of the app service plan."
  type        = string
  default     = "asp-linux-webapp"
}

variable "location" {
  description = "The location of the app service plan."
  type        = string
  default     = "South Africa North"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-default-infra-tfstate"
}

variable "kind" {
  description = "The kind of the app service plan."
  type        = string
  default     = "Linux"
}

