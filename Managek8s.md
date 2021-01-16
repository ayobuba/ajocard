# Configure the provider

```shell
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  load_config_file       = false

  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
```

```shell
Note: The Kubernetes provider will automatically use kubectl's current configuration context unless load_config_file is set to false.
```
# Schedule the deployment
```shell
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
```
```shell
kubectl get deployments
```

# Schedule the deployment(Loadbalancer on cloud provider)
```shell
resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
```

Add the following config. This will set the "lb-ip" to your AWS ingress hostname
```shell
output "lb-ip" {
  value = kubernetes_service.nginx.load_balancer_ingress[0].ip
}
```

after apply, verufy nginx is running
```shell
kubectl get services
```

#Scale the Deployment
you can scale the deployment by increasing the "replicas" field.eg
```shell
resource "kubernetes_deployment" "nginx" {
  # ...

  spec {
    replicas = 4

    # ...
  }

  # ...
}
```

Verify by running
```shell
kubectl get deployments
```