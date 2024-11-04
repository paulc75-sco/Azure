#Create a resource group
resource "azurerm_resource_group" "AVS_RG" {
  name     = var.rgname
  location = var.location


}
#Creates the AVS Cluster
resource "azurerm_vmware_private_cloud" "AVS" {
  name                = var.avs_name
  resource_group_name = azurerm_resource_group.AVS_RG.name
  location            = var.location
  sku_name            = var.avssku

  management_cluster {

    size = var.avs_nodes
  }

  network_subnet_cidr         = var.avs_cidr
  internet_connection_enabled = var.avs_internet_connection_enabled
  nsxt_password               = var.avs_nsxt_password
  vcenter_password            = var.avs_vcenter_password

}
