#
#variable "max_pods" {}
#variable "kube_reserved_cpu" {}
#variable "kube_reserved_memory" {}
#variable "kube_reserved_ephemeral_storage" {}
#variable "system_reserved_cpu" {}
#variable "system_reserved_memory" {}
#variable "system_reserved_ephemeral_storage" {}
#variable "evict_hard_memory_avail" {}
#variable "evict_hard_nodefs_avail" {}
#variable "evict_soft_grace_imagefs" {}
#variable "evict_soft_grace_memory" {}
#variable "evict_soft_grace_nodefs_inodes" {}
#variable "evict_soft_grace_nodefs_avail" {}
#variable "eviction_max_pod_grace_period" {}
#variable "evict_soft_imagefs_avail" {}
#variable "evict_soft_memory_avail" {}
#variable "evict_soft_nodefs_avail" {}
#variable "evict_soft_inodes_free" {}
#variable "ec2_disk" {}
#variable "nodes_defaults" {
#  type = map(string)
#}
#variable "subnet_ids" {
#  description = "A list of subnet IDs to launch resources in"
#  type        = list(string)
#  validation {
#    condition = (
#    length(var.subnet_ids) > 0
#    )
#    error_message = "You must specify at least 1 subnet to launch resources in."
#  }
#}
#variable "cluster_name" {
#  type        = string
#  description = "The name of the EKS cluster"
#}
#
#variable "node_group_instance_types" {
#  type        = list(string)
#  default     = ["c6a.8xlarge", "c4.8xlarge", "r4.8xlarge"]
#  description = <<-EOT
#    Instance types to use for this node group (up to 20). Defaults to ["t3.medium"].
#    Must be empty if the launch template configured by `launch_template_id` specifies an instance type.
#    EOT
#  validation {
#    condition = (
#    length(var.node_group_instance_types) <= 20
#    )
#    error_message = "Per the EKS API, no more than 20 instance types may be specified."
#  }
#}
#
#variable "desired_size" {}
#variable "max_size" {}
#variable "min_size" {}
#
#variable "cluster_defaults" {
#  type = map(string)
#}