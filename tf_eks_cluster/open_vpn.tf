//# OpenVPN EC2
//resource "aws_autoscaling_group" "NodeGroup" {
//  name                 = "NodeASGroup"
//  max_size             = 1
//  min_size             = 1
//  desired_capacity     = 1
//  launch_configuration = aws_launch_configuration.NodeLaunchConfig.name
//  vpc_zone_identifier = [module.vpc.public_subnets[0],
//    module.vpc.public_subnets[1],
//  module.vpc.public_subnets[2]]
//  tag {
//    key                 = "Project"
//    propagate_at_launch = true
//    value               = "OpenVPN"
//  }
//  tag {
//    key                 = "Name"
//    propagate_at_launch = true
//    value               = "OpenVPN Server"
//  }
//}
//
//resource "aws_launch_configuration" "NodeLaunchConfig" {
//  name          = "NodeLaunchConfig-${random_string.suffix.result}"
//  image_id      = var.open_vpn_ami
//  instance_type = var.instance_type
//  //key_name             = var.keyname
//  security_groups      = [aws_security_group.NodeSecurityGroup.id]
//  iam_instance_profile = aws_iam_instance_profile.NodeInstanceProfile.id
//  ebs_block_device {
//    device_name           = "/dev/xvda"
//    volume_size           = 8
//    volume_type           = "gp2"
//    delete_on_termination = true
//  }
//  user_data_base64 = base64encode(local.instance-userdata)
//
//  lifecycle {
//    create_before_destroy = true
//  }
//}
//
//
//
//resource "aws_security_group" "NodeSecurityGroup" {
//  name        = "NodeSecurityGroup"
//  description = "Security group for all nodes in the cluster"
//  vpc_id      = module.vpc.vpc_id
//}
//
//
//
//resource "aws_security_group_rule" "NodeSecurityGroupIngressTCP443" {
//  from_port         = 443
//  protocol          = "tcp"
//  security_group_id = aws_security_group.NodeSecurityGroup.id
//  to_port           = 443
//  type              = "ingress"
//  cidr_blocks       = [var.AllowedIpRange]
//
//}
//
//resource "aws_security_group_rule" "NodeSecurityGroupIngressSSH22" {
//  from_port         = 22
//  protocol          = "tcp"
//  security_group_id = aws_security_group.NodeSecurityGroup.id
//  to_port           = 22
//  type              = "ingress"
//  cidr_blocks       = [var.AllowedIpRange]
//}
//
//resource "aws_security_group_rule" "NodeSecurityGroupIngressTCP943" {
//  from_port         = 943
//  protocol          = "tcp"
//  security_group_id = aws_security_group.NodeSecurityGroup.id
//  to_port           = 943
//  type              = "ingress"
//  cidr_blocks       = [var.AllowedIpRange]
//}
//
//resource "aws_security_group_rule" "NodeSecurityGroupIngressTCP945" {
//  from_port         = 945
//  protocol          = "tcp"
//  security_group_id = aws_security_group.NodeSecurityGroup.id
//  to_port           = 945
//  type              = "ingress"
//  cidr_blocks       = [var.AllowedIpRange]
//}
//
//resource "aws_security_group_rule" "NodeSecurityGroupIngressUDP1194" {
//  from_port         = 1194
//  protocol          = "udp"
//  security_group_id = aws_security_group.NodeSecurityGroup.id
//  to_port           = 1194
//  type              = "ingress"
//  cidr_blocks       = [var.AllowedIpRange]
//}
//
//resource "aws_security_group_rule" "NodeSecurityGroupEgress" {
//  from_port         = 0
//  protocol          = "-1"
//  security_group_id = aws_security_group.NodeSecurityGroup.id
//  to_port           = 0
//  type              = "egress"
//  cidr_blocks       = [var.AllowedIpRange]
//}
//
//resource "aws_iam_role" "NodeRole" {
//  name = "NodeRole"
//
//  assume_role_policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Action": "sts:AssumeRole",
//      "Principal": {
//        "Service": "ec2.amazonaws.com"
//      },
//      "Effect": "Allow",
//      "Sid": ""
//    }
//  ]
//}
//EOF
//
//  tags = {
//    tag-key = "tag-value"
//  }
//}
//
//resource "aws_iam_role_policy" "NodeRolePolicies" {
//  name = "NodeRolePolicies"
//  role = aws_iam_role.NodeRole.id
//
//  policy = <<-EOF
//  {
//    "Version": "2012-10-17",
//    "Statement": [
//      {
//        "Action": [
//          "*"
//        ],
//        "Effect": "Deny",
//        "Resource": "*"
//      }
//    ]
//  }
//  EOF
//}
//
//resource "aws_iam_instance_profile" "NodeInstanceProfile" {
//  path = "/openvpn/"
//  role = aws_iam_role.NodeRole.id
//}
//
//
//
//
//
//
