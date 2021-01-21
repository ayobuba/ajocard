output "gke_cluster" {
  value = var.cluster
}

output "node-endpoint" {
  value = kubernetes_service.node_app.load_balancer_ingress.0.ip
}

output "go-endpoint" {
  value = kubernetes_service.go_app.load_balancer_ingress.0.ip
}