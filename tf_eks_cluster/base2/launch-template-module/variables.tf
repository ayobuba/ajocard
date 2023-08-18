variable "vpc_id" {
  default = "vpc-0f5b20b0889605ad2"
}
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
variable "ec2_disk" {}
variable "nodes_defaults" {
  type = map(string)
}
variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
  validation {
    condition = (
      length(var.subnet_ids) > 0
    )
    error_message = "You must specify at least 1 subnet to launch resources in."
  }
}

#variable "associate_public_ip_address" {
#  type = bool
#}

#variable "node_ami_id" {
#  description = "Node AMI"
#}

variable "cluster_defaults" {
  type = map(string)
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(any)
  default     = []
}

variable "block_device_mappings" {
  type        = list(any)
  description = <<-EOT
    List of block device mappings for the launch template.
    Each list element is an object with a `device_name` key and
    any keys supported by the `ebs` block of `launch_template`.
    EOT
  # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template#ebs
  default = [{
    device_name = "/dev/xvda"
    #    volume_type           = "gp2"
    #    encrypted             = true
    volume_size           = 250
    delete_on_termination = true
  }]
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Set false to disable the Instance Metadata Service."
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 10
  description = <<-EOT
    The desired HTTP PUT response hop limit (between 1 and 64) for Instance Metadata Service requests.
    The default is `2` to support containerized workloads.
    EOT
  validation {
    condition = (
      var.metadata_http_put_response_hop_limit >= 10
    )
    error_message = "IMDS hop limit must be at least 10 to support EKS functionality."
  }
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = false
  description = "Set true to require IMDS session tokens, disabling Instance Metadata Service Version 1."
}
####
variable "node_group_name" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "node_group_instance_types" {
  type        = list(string)
  default     = ["c6a.8xlarge", "c4.8xlarge", "r4.8xlarge"]
  description = <<-EOT
    Instance types to use for this node group (up to 20). Defaults to ["t3.medium"].
    Must be empty if the launch template configured by `launch_template_id` specifies an instance type.
    EOT
  validation {
    condition = (
      length(var.node_group_instance_types) <= 20
    )
    error_message = "Per the EKS API, no more than 20 instance types may be specified."
  }
}

variable "nodegroup_role_name" {}

#variable "regions" {
#}
#
#variable "vpc" {
#  type = map(string)
#}
#
#variable "env" {
#}
#

#

#
#
#
#variable "eks_version" {}


