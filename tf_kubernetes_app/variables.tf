variable "cluster" {
  default = "ajocard-cluster"
}
variable "node_app" {
  type        = string
  description = "Name of application"
  default     = "node"
}

variable "go_app" {
  type        = string
  description = "Name of application"
  default     = "go"
}

variable "zone" {
  default = "us-east1-d"
}

variable "docker-image-node" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "ayobuba/ajocard-node:latest"
}

variable "docker-image-go" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "ayobuba/go-docker:latest"
}

variable "region" {

}

variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}