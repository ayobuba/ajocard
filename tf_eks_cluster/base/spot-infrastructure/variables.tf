#variable "access_key" {
#
#}
#variable "secret_key" {
#
#}

variable "aws_region" {
  description = "AWS region "
}
variable "aws_autoscaling_group_name" {

}
variable "prefix_sc_dev_us" {
  default = "sc-dev-us"
}
variable "prefix_sc_prod_eu" {
  default = "sc-prod-eu"
}
variable "prefix_sc_prod_us" {
  default = "sc-prod-us"
}
variable "sqs_que_prefix" {

}

variable "aws_account_id" {

}
