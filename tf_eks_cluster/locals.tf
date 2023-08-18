# You can use locals as shortcut for complicated variables
# ie. ${local.name_prefix}-vpc
locals {
  name_prefix   = "${var.app_name}-${var.app}"
  account_id    = data.aws_caller_identity.current.account_id
  account_alias = data.aws_iam_account_alias.current.account_alias
  //tags              = merge(var.global_tags, map("App", var.app_name, "Instance", var.app, "Stage", var.app_stage))
  cluster_name      = "${var.app_name}-${random_string.suffix.result}"
  instance-userdata = <<EOF
    #!/bin/bash
    sudo /usr/local/openvpn_as/scripts/sacli --key "${var.vpn_key_1}" --value "${module.cpp_vpc.vpc_cidr_block}" ConfigPut
    sudo /usr/local/openvpn_as/scripts/sacli --user ${var.VpnInitialUsername} --new_pass ${var.VpnInitialPassword} SetLocalPassword
    sudo /usr/local/openvpn_as/scripts/sacli --key "${var.vpn_key_2}" --value "${var.SecondaryVPCCidr}" ConfigPut
    sudo /usr/local/openvpn_as/scripts/sacli start
  EOF
  oidc = {
    arn = aws_iam_openid_connect_provider.oidc.arn
    url = replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")
  }
  oidc_map = zipmap(["url", "arn"], [local.oidc["url"], local.oidc["arn"]])
  asg_names = data.aws_autoscaling_groups.groups.names
  eks_oidc = replace(replace(module.cpp_eks.cluster_endpoint, "https://", ""), "/\\..*$/", "")

#  staging-eks-nodes-userdata = <<USERDATA
#      #!/bin/bash -xe
#      set -o xtrace
#      sudo yum install nfs-utils -y
#      /etc/eks/bootstrap.sh --use-max-pods '${var.max_pods}' --kubelet-extra-args '--kube-reserved cpu=${var.kube_reserved_cpu},
#      memory=${var.kube_reserved_memory},ephemeral-storage=${var.kube_reserved_ephemeral_storage}
#       --system-reserved cpu=${var.system_reserved_cpu},memory=${var.system_reserved_memory},
#      ephemeral-storage=${var.system_reserved_ephemeral_storage} --eviction-hard memory.available<${var.evict_hard_memory_avail},
#      nodefs.available<${var.evict_hard_nodefs_avail} --eviction-soft-grace-period imagefs.available<${var.evict_soft_grace_imagefs},
#      memory.available<${var.evict_soft_grace_memory},nodefs.inodesFree<${var.evict_soft_grace_nodefs_inodes},
#      nodefs.available<${var.evict_soft_grace_nodefs_avail}
#       --eviction-max-pod-grace-period ${var.eviction_max_pod_grace_period} --eviction-soft imagefs.available<${var.evict_soft_imagefs_avail},
#      memory.available<${var.evict_soft_memory_avail},nodefs.available<${var.evict_soft_nodefs_avail},
#      nodefs.inodesFree<${var.evict_soft_inodes_free} --kubeconfig /var/lib/kubelet/kubeconfig' '${var.cluster_defaults["name"]}'
#      crontab<<EOF
#      0 1 * * * sudo docker system prune -a -f
#      0 1 * * * sudo yum --security update -y
#      EOF
#      sudo yum update -y
#      sudo reboot
#      USERDATA
}



#  ng = {
#    cluster_name              = var.cluster_name
#    subnet_ids                = sort(var.subnet_ids)
#    node_group_instance_types = sort(var.node_group_instance_types)
#
#
#    scaling_config = {
#      desired_size = var.desired_size
#      max_size     = var.max_size
#      min_size     = var.min_size
#    }
#  }

#locals {
#  oidc = {
#    arn = aws_iam_openid_connect_provider.oidc.arn
#    url = replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")
#  },
#  oidc_map = zipmap(["url", "arn"], [local.oidc["url"], local.oidc["arn"]]
#
#  }
#  }
