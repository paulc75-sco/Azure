variable "name" {

}

variable "location" {
  default = "West Europe"

}


variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default = {
    environment = "Missing Tag"
    group       = "Digital Transformation"
    owner       = "Digital Transformation"

  }

}
