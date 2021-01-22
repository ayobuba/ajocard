variable "project_id" {
  default = "devops-challenge-302120"
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-d"
}

variable "cluster" {
  default = "ajocard-cluster"
}

variable "credentials" {
  default = "$GOOGLE_CLOUD_TOKEN"
}

variable "kubernetes_min_ver" {
  default = "latest"
}

variable "kubernetes_max_ver" {
  default = "latest"
}