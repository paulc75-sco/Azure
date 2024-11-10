output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster.                This certificate is used in conjunction with the client key for client certificate authentication."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
}

output "kube_config" {
  description = "Raw Kubernetes configuration in YAML format. Contains all necessary information to connect                to the cluster including endpoints, certificates, and credentials. This should be handled securely as it provides full cluster access."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

output "cluster_identity" {
  description = "The principal ID of the system-assigned identity of the AKS cluster. This ID can be used to assign roles to the cluster identity for accessing other Azure resources like ACR, Key Vault, etc."
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "kubelet_identity" {
  description = "The object ID of the user-assigned identity used by the Kubelets. This identity is used by the node's kubelet service to interact with Azure resources like pulling images from ACR or accessing blob storage."
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "node_resource_group" {
  description = "The auto-generated Resource Group name which contains the resources for this Managed Kubernetes Cluster.  This is where resources like VMs, load balancers, and managed disks are created by AKS."
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}
