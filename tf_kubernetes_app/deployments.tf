# node app deployment manifest
resource "kubernetes_deployment" "node_app" {
  metadata {
    name = var.node_app
    labels = {
      app = var.node_app
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.node_app
      }
    }

    template {
      metadata {
        labels = {
          app = var.node_app
        }
      }

      spec {
        container {
          image = var.docker-image-node
          name  = var.node_app
          port {
            name           = "port-5000"
            container_port = 5000
          }
        }
      }
    }
  }
}

# go app deployment manifest
resource "kubernetes_deployment" "go_app" {
  metadata {
    name = var.go_app
    labels = {
      app = var.go_app
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.go_app
      }
    }

    template {
      metadata {
        labels = {
          app = var.go_app
        }
      }

      spec {
        container {
          image = var.docker-image-go
          name  = var.go_app
          port {
            name           = "port-8083"
            container_port = 8084
          }
        }
      }
    }
  }
  create_before_destroy = true
}
