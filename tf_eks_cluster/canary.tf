//# node app deployment manifest
//variable "canary" {
//  type        = string
//  description = "Name of application"
//  default     = "canary-app"
//}
//
//variable "image" {
//  type        = string
//  description = "name of the docker image to deploy"
//  default     = "ayobuba/ajocard-node:latest"
//}
//
//resource "kubernetes_deployment" "canary-deployment" {
//  metadata {
//    name = "canary-deployment"
//
//  }
//
//  spec {
//    replicas = 1
//    selector {
//      match_labels = {
//        app = "aspnetcore"
//        track =  "canary"
//      }
//    }
//
//    template {
//      metadata {
//        labels = {
//          app = "aspnetcore"
//          track = "canary"
//        }
//      }
//
//      spec {
//        container {
//          image = var.canary
//          name  = var.canary
//          image_pull_policy = "IfNotPresent"
//          port {
//            name           = "port-80"
//            container_port = 80
//          }
//          readiness_probe {
//            http_get {
//              path = "/"
//              port = "80"
//            }
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
//
//# node app service manifest
////resource "kubernetes_service" "node_app" {
////  metadata {
////    name = var.canary
////  }
////  spec {
////    selector = {
////      app = kubernetes_deployment.node_app.metadata.0.labels.app
////    }
////    port {
////      port        = 80
////      target_port = 5000
////    }
////
////    type = "LoadBalancer"
////  }
////}