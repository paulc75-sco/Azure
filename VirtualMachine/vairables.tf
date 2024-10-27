variable "name" {

}

variable "location" {
  default = "West Europe"

}

variable "resource_group" {

}

variable "allocation_method" {
  default = "Dynamic"

}

variable "subnet_id" {

}

variable "vmsize" {
  default = "Standard_B1s"

}

variable "username" {
  default = "adminuser"

}

variable "caching" {
  default = "Readwrite"

}

variable "storage_account_type" {
  default = "Standard_LRS"

}

variable "publisher" {
  default = "Canonical"

}

variable "offer" {
  default = "UbuntuServer"

}

variable "sku" {
  default = "18.04-LTS"

}

variable "imageversion" {
  default = "latest"

}


