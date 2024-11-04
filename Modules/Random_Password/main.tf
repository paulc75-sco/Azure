resource "random_password" "secure_password" {
  length           = 20
  special          = true
  override_special = "!@#$%&*"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2

}

output "password" {
  value = random_password.secure_password.result

}
