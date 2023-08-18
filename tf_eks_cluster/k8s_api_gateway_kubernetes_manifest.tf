#resource "kubernetes_cluster_role" "alb-ingress-controller" {
#  metadata {
#    labels = {
#      "app.kubernetes.io/name" = "alb-ingress-controller"
#    }
#    name = "alb-ingress-controller"
#  }
#  rule {
#    api_groups = ["", "extensions"]
#    resources = ["configmaps","endpoints","events","ingresses","ingresses/status","services","pods/status"]
#    verbs = ["create","get","list","update","watch","patch"]
#
#  }
#
#}