locals {
  asg_names = data.aws_autoscaling_groups.sc_stg_groups.names
  //asg_names = data.aws_autoscaling_groups.sc_stg_groups.names
}