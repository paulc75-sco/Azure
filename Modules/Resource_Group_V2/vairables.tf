#GLobal vairables decleration
variable "global_name" {

}

variable "global_location" {
  default = "West Europe"

}

variable "global_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}

}
