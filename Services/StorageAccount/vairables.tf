variable "name" {

}

variable "location" {
  default = "West Europe"
}

variable "account_tier" {
  default = "Standard"

}

variable "account_replication_type" {
  default = "LRS"

}

variable "container_name" {

}

variable "container_access_type" {
  default = "private"

}

variable "tags" {
  type = map(string)
}

variable "subscription_id" {
  type = string

}
