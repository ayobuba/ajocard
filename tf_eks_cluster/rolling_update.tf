//# node app deployment manifest
//variable "node_app" {
//  type        = string
//  description = "Name of application"
//  default     = "my-nginx"
//}
//
//variable "docker-image-node" {
//  type        = string
//  description = "name of the docker image to deploy"
//  default     = "ayobuba/ajocard-node:latest"
//}
//
//resource "kubernetes_deployment" "node_app" {
//  metadata {
//    name = var.node_app
//    labels = {
//      app = var.node_app
//    }
//  }
//
//  spec {
//    replicas                  = 2
//    min_ready_seconds         = 2
//    progress_deadline_seconds = 60
//    revision_history_limit    = 5
//    strategy {
//      type = "RollingUpdate"
//      rolling_update {
//        max_surge       = "1"
//        max_unavailable = "1"
//      }
//    }
//    selector {
//      match_labels = {
//        app = var.node_app
//      }
//    }
//
//    template {
//      metadata {
//        labels = {
//          app = var.node_app
//        }
//      }
//
//      spec {
//        container {
//          image = var.docker-image-node
//          name  = var.node_app
//          port {
//            name           = "port-5000"
//            container_port = 5000
//          }
//          resources {
//            limits {
//              memory = "123Mi"
//              cpu    = "200m"
//            }
//          }
//        }
//      }
//    }
//  }
//}
//
//# node app service manifest
//resource "kubernetes_service" "node_service" {
//  metadata {
//    name = var.node_app
//  }
//  spec {
//    selector = {
//      app = kubernetes_deployment.node_app.metadata.0.labels.app
//    }
//    port {
//      port        = 80
//      target_port = 5000
//    }
//
//    type = "LoadBalancer"
//  }
//}