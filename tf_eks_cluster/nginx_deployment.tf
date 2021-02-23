//variable "my_nginx" {
//  default = "my-nginx"
//}
//resource "kubernetes_deployment" "nginx_deployemt" {
//  metadata {
//    name = var.my_nginx
//    labels = {
//      app = var.my_nginx
//    }
//  }
//  spec {
//    replicas = 2
//    selector {
//      match_labels = {
//        app = var.my_nginx
//      }
//    }
//    template {
//      metadata {
//        labels = {
//          app = var.my_nginx
//        }
//      }
//      spec {
//        container {
//          name = var.my_nginx
//          image = "nginx:alpine"
//          port {
//            container_port = 80
//          }
//          resources {
//            limits {
//              memory = "123Mi"
//              cpu = "200m"
//            }
//          }
//        }
//      }
//    }
//  }
//}