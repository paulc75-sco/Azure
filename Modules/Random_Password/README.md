# Random Password Generator Terraform Module

This Terraform module generates a secure random password that meets specific complexity requirements. It's designed to create strong passwords for use in infrastructure deployments while ensuring compliance with common password policies.

## Features

- 🔒 20-character password length
- 🔣 Special character support
- 🔡 Minimum character type requirements
- 🛡️ Controlled special character set
- ✅ Predictable complexity rules

## Prerequisites

- Terraform >= 0.13.x
- random provider configured

## Usage

```hcl
module "password_generator" {
  source = "./path/to/module"
}
```

### Password Requirements

The generated password will meet the following criteria:
- Total length: 20 characters
- Minimum 2 lowercase letters
- Minimum 2 uppercase letters
- Minimum 2 numbers
- Minimum 2 special characters
- Special characters limited to: !@#$%&*

## Input Variables

This module currently doesn't accept any input variables as it uses hardcoded best-practice values. If you need to customize the password requirements, you'll need to modify the module source code.

Default password requirements:
```hcl
length           = 20
special          = true
override_special = "!@#$%&*"
min_lower        = 2
min_upper        = 2
min_numeric      = 2
min_special      = 2
```

## Outputs

| Name | Description |
|------|-------------|
| password | The generated random password. This value is sensitive and should be handled securely. |

## Example Usage with Other Resources

```hcl
# Generate password
module "admin_password" {
  source = "./path/to/module"
}

# Use the password with an Azure SQL Database
resource "azurerm_mssql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name          = "example-resources"
  location                     = "East US"
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = module.admin_password.password
}
```

## Security Considerations

1. The password output is marked as sensitive in Terraform
2. Store state files securely as they will contain the password value
3. Use appropriate backend configurations with encryption
4. Consider using a secrets management solution for production environments
5. Rotate passwords regularly according to your security policies

## Best Practices

1. **State Management**
   - Use remote state with encryption
   - Implement state locking
   - Restrict state access to authorized users

2. **Password Handling**
   - Don't commit passwords to version control
   - Use secrets management systems when possible
   - Implement password rotation policies

3. **Module Usage**
   - Generate unique passwords for each resource
   - Don't reuse passwords across environments
   - Consider using dedicated secret management services for production

## Known Limitations

1. Password cannot be specified manually
2. Character set for special characters is fixed
3. Length is fixed at 20 characters

## Future Improvements

Potential future enhancements could include:
- Configurable password length
- Customizable special character set
- Optional complexity requirements
- Password expiration tracking

## License

This module is licensed under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues and feature requests, please submit an issue in the repository.

---
**Note**: This module generates passwords that are stored in the Terraform state. Ensure you're following security best practices for managing your Terraform state files.