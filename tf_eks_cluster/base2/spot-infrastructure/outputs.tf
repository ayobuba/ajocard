#output "oidc" {
#  description = "The OIDC provider attributes for IAM Role for ServiceAccount"
#  value = zipmap(["url", "arn"], [local.oidc["url"], local.oidc["arn"]]
#  )
#}