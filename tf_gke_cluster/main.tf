variable "app_name" {
  default = "ajocard-gke"
}
resource "google_container_cluster" "primary" {
  name               = var.cluster
  location           = var.zone
  initial_node_count = 3

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      app = var.app_name
    }

    tags = ["app", var.app_name]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "null_resource" "gke_cluster_credentials" {

  provisioner "local-exec" {
    //command = "echo ${google_container_cluster.primary.name} >> private_ips.txt"
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone=${var.zone}"
  }
  depends_on = [google_container_cluster.primary]
}