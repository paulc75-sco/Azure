variable "rgname" {
  type = string

}

variable "location" {
  type    = string
  default = "West Europe"

}

variable "key_vault_sku" {
  type    = string
  default = "standard"

}

variable "vnet_name" {
  type = string

}

variable "vnet_address_space" {
  type = list(any)

}

variable "subnet_name" {
  type = string
}

variable "subnet_prefix" {
  type = list(any)

}

variable "nicname" {
  type = string

}

variable "ip_config_name" {
  type = string

}

variable "ip_allocation" {
  type    = string
  default = "Dynamic"

}

variable "vmname" {
  type = string

}


variable "vmsize" {
  type    = string
  default = "Standard_B1s"

}

variable "admin_username" {
  type    = string
  default = "adminuser"

}

variable "caching" {
  type    = string
  default = "ReadWrite"

}

variable "storage_account_type" {
  type    = string
  default = "Standard_LRS"

}

variable "publisher" {
  type    = string
  default = "canonical"

}

variable "offer" {
  type    = string
  default = "UbuntuServer"
}

variable "sku" {
  type    = string
  default = "19_10-daily-gen2"

}

variable "vm_version" {
  type    = string
  default = "latest"

}
