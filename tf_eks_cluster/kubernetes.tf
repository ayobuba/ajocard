# # Kubernetes provider
# # https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/terraform/kubernetes/deploy-nginx-kubernetes

//resource "helm_release" "operator" {
//  name       = "terraform-operator"
//  repository = "https://helm.releases.hashicorp.com"
//  chart      = "terraform"
//
//  namespace = "terraform-cloud"
//
//}

//resource "kubernetes_namespace" "beacon" {
//  metadata {
//    name = "beacon"
//  }
//}


//resource "kubernetes_deployment" "beacon" {
//  metadata {
//    name      = var.application_name
//    namespace = kubernetes_namespace.beacon.id
//    labels = {
//      app = var.application_name
//    }
//  }
//
//  spec {
//    replicas = 3
//
//    selector {
//      match_labels = {
//        app = var.application_name
//      }
//    }
//
//    template {
//      metadata {
//        labels = {
//          app = var.application_name
//        }
//      }
//
//      spec {
//        container {
//          image = "onlydole/beacon:datadog"
//          name  = var.application_name
//        }
//      }
//    }
//  }
//}
//
//
//
//resource "kubernetes_service" "beacon" {
//  metadata {
//    name      = var.application_name
//    namespace = kubernetes_namespace.beacon.id
//  }
//  spec {
//    selector = {
//      app = kubernetes_deployment.beacon.metadata[0].labels.app
//    }
//    port {
//      port        = 8080
//      target_port = 80
//    }
//    type = "LoadBalancer"
//  }
//}
//
//
//output "beacon_endpoint" {
//  value = "${kubernetes_service.beacon.status[0].load_balancer[0].ingress[0].hostname}:8080"
//}




