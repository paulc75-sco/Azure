variable "rgname" {
  type = string

}

variable "location" {
  type    = string
  default = "West Europe"

}

variable "avs_name" {
  type = string

}

variable "avssku" {
  type    = string
  default = "av36"

}

variable "avs_nodes" {
  type    = string
  default = "3"

}

variable "avs_cidr" {
  type = string

}

variable "avs_internet_connection_enabled" {
  type    = bool
  default = false
}

variable "avs_nsxt_password" {
  type = string

}
variable "avs_vcenter_password" {
  type = string

}

variable "subscription_id" {
  type = string

}
