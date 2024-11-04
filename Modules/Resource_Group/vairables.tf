variable "name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Region to deploy resources"
  type        = string
  default     = "West Europe"

}


variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default = {
    environment = "Missing Tag"
    group       = "Missing Tag"
    owner       = "Missing Tag"

  }

}
