variable "rgname" {
  description = "Resource group name"
  type        = string

}

variable "location" {
  description = "Deployed region"
  type        = string
  default     = "West Europe"

}

variable "avs_name" {
  description = "Name of AVS Deployment"
  type        = string

}

variable "avssku" {
  description = "AVS SKU"
  type        = string
  default     = "av36"

}

variable "avs_nodes" {
  description = "AVS node count"
  type        = string
  default     = "3"

}

variable "avs_cidr" {
  description = "CIDR required for AVS cluster.  Must be /22"
  type        = string

}

variable "avs_internet_connection_enabled" {
  description = "AVS internet connection"
  type        = bool
  default     = false
}

variable "avs_nsxt_password" {
  description = "Sets NSXT password"
  type        = string
  sensitive   = true

}
variable "avs_vcenter_password" {
  description = "Sets vcentre password"
  type        = string
  sensitive   = true

}

variable "subscription_id" {
  description = "Sets subscription id in provider files"
  type        = string
  sensitive   = true

}
