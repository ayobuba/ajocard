# You can use locals as shortcut for complicated variables
# ie. ${local.name_prefix}-vpc
locals {
  name_prefix       = "${var.app_name}-${var.app}-${var.app_stage}"
  account_id        = data.aws_caller_identity.current.account_id
  account_alias     = data.aws_iam_account_alias.current.account_alias
  tags              = merge(var.global_tags, map("App", var.app_name, "Instance", var.app, "Stage", var.app_stage))
  cluster_name      = "AjoCard-EKS-${random_string.suffix.result}"
  instance-userdata = <<EOF
    #!/bin/bash
    sudo /usr/local/openvpn_as/scripts/sacli --key "${var.vpn_key_1}" --value "${module.vpc.vpc_cidr_block}" ConfigPut
    sudo /usr/local/openvpn_as/scripts/sacli --user ${var.VpnInitialUsername} --new_pass ${var.VpnInitialPassword} SetLocalPassword
    sudo /usr/local/openvpn_as/scripts/sacli --key "${var.vpn_key_2}" --value "${var.SecondaryVPCCidr}" ConfigPut
    sudo /usr/local/openvpn_as/scripts/sacli start
  EOF
}
