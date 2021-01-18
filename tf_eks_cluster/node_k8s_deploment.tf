//resource "kubernetes_deployment" "node_deployment" {
//  metadata {
//    name = var.app
//    labels = {
//      app = var.app
//    }
//  }
//  spec {
//    replicas = 3
//
//    selector {
//      match_labels = {
//        app = var.app
//      }
//    }
//    template {
//      metadata {
//        labels = {
//          app = var.app
//        }
//      }
//      spec {
//        container {
//          image = var.go-docker-image
//          name  = var.app
//          port {
//            name           = "port-5000"
//            container_port = 8083
//          }
//        }
//      }
//    }
//  }
//}
//
//resource "kubernetes_service" "node_service" {
//  metadata {
//    name = var.app
//  }
//  spec {
//    selector = {
//      app = kubernetes_deployment.go_deploment.metadata.0.labels.app
//    }
//    port {
//      port        = 80
//      target_port = 8083
//    }
//    type = "LoadBalancer"
//  }
//}