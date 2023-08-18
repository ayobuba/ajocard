
resource "aws_eks_node_group" "this" {
  cluster_name    = local.ng.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.nodes_role_policy_arn
  //node_role_arn   = aws_iam_role.sc-stg-ng_role.arn
  subnet_ids = local.ng.subnet_ids
  #  subnet_ids     = data.aws_subnet_ids.sc-stg-eks-subnets.ids
  instance_types = local.ng.node_group_instance_types
  capacity_type  = "SPOT"
  scaling_config {
    desired_size = local.ng.scaling_config.desired_size
    max_size     = local.ng.scaling_config.max_size
    min_size     = local.ng.scaling_config.min_size
  }

  update_config {
    max_unavailable = 2
  }

  launch_template {
    #version = var.launch_template_version #"latest_version"
    version = aws_launch_template.main.latest_version #"latest_version"
    name    = aws_launch_template.main.name
    #    version = "latest_version"
    #    name    = "eks-config20220115200649853800000001"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_launch_template.main
  ]
}


#resource "aws_iam_role" "sc-stg-ng_role" {
#  name = var.nodegroup_role_name #"sc-stg-ng-node-group-role"
#
#  assume_role_policy = jsonencode({
#    Statement = [{
#      Action = "sts:AssumeRole"
#      Effect = "Allow"
#      Principal = {
#        Service = "ec2.amazonaws.com"
#      }
#    }]
#    Version = "2012-10-17"
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "sc-stg-ng-AmazonEKSWorkerNodePolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#  role       = aws_iam_role.sc-stg-ng_role.name
#}
#
#resource "aws_iam_role_policy_attachment" "sc-stg-ng-AmazonEKS_CNI_Policy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#  role       = aws_iam_role.sc-stg-ng_role.name
#}
#
#resource "aws_iam_role_policy_attachment" "sc-stg-ng-AmazonEC2ContainerRegistryReadOnly" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#  role       = aws_iam_role.sc-stg-ng_role.name
#}

#dont use
#resource "aws_eks_node_group" "sc-stg-ng" {
#  for_each        = { for ng in var.managed_node_groups : ng.name => ng }
#  cluster_name    = var.cluster_name
#  node_group_name = join("-", [aws_eks_cluster.cp.name, each.key])
#  node_role_arn   = aws_iam_role.ng.0.arn
#  subnet_ids      = local.subnet_ids
#  ami_type        = lookup(each.value, "ami_type", local.default_eks_config.ami_type)
#  instance_types  = [lookup(each.value, "instance_type", local.default_eks_config.instance_type)]
#  version         = aws_eks_cluster.cp.version
#  tags            = merge(local.default-tags, var.tags)
#
#  scaling_config {
#    max_size     = lookup(each.value, "max_size", 3)
#    min_size     = lookup(each.value, "min_size", 1)
#    desired_size = lookup(each.value, "desired_size", 1)
#  }
#
#  launch_template {
#    id      = aws_launch_template.mng[each.key].id
#    version = aws_launch_template.mng[each.key].latest_version
#  }
#
#  lifecycle {
#    create_before_destroy = true
#    ignore_changes        = [scaling_config[0].desired_size]
#  }

#  depends_on = [
#    aws_iam_role.ng,
#    aws_iam_role_policy_attachment.eks-ng,
#    aws_iam_role_policy_attachment.eks-cni,
#    aws_iam_role_policy_attachment.ecr-read,
#    time_sleep.wait,
#  ]
#}