variable "id" {
  description = "The app service ID."
  type        = string
  default     = "/subscriptions/d4aed6b4-8573-4645-b7a3-3cf34177e822/resourceGroups/rg-default-infra-tfstate/providers/Microsoft.Web/sites/app-terragrunt"
  sensitive   = true
}

variable "name" {
  description = "The name of the app service."
  type        = string
  default     = "app-terragrunt"
}

variable "location" {
  description = "The location of the app service."
  type        = string
  default     = "South Africa North"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-default-infra-tfstate"
}

variable "app_service_plan_id" {
  description = "The app service plan ID associated with the app service."
  type        = string
  default     = "/subscriptions/d4aed6b4-8573-4645-b7a3-3cf34177e822/resourceGroups/rg-default-infra-tfstate/providers/Microsoft.Web/serverFarms/asp-linux-webapp"
  sensitive   = true
}
