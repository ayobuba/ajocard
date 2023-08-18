data "aws_autoscaling_groups" "groups" {
  filter {
    name   = "tag-key"
    values = ["eks:nodegroup-name"]
  }

}