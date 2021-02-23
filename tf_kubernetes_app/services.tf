# node app service manifest
resource "kubernetes_service" "node_app" {
  metadata {
    name = var.node_app
  }
  spec {
    selector = {
      app = kubernetes_deployment.node_app.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}


# node app service manifest
//resource "kubernetes_service" "go_app" {
//  metadata {
//    name = var.go_app
//  }
//  spec {
//    selector = {
//      app = kubernetes_deployment.go_app.metadata.0.labels.app
//    }
//    port {
//      port        = 8083
//      target_port = 8083
//    }
//
//    type = "LoadBalancer"
//  }
//}