terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.3"
    }
  }
}

provider "docker" {}

# 1. Build the Docker image from a local Dockerfile
resource "docker_image" "services_image" {
  name = "pipeline-status-api"

  build {
    context    = "${path.module}/../../../services/pipeline-status-api" # Path to directory containing your Dockerfile
    dockerfile = "Dockerfile"
    tag        = ["pipeline-status-api"]
  }
}

# 1. Build the Docker image from a local Dockerfile
resource "docker_image" "nginx_image" {
  name = "services-nginx"

  build {
    context    = "${path.module}/../../nginx" # Path to directory containing your Dockerfile
    dockerfile = "Dockerfile"
    tag        = ["services-nginx"]
  }
}

# 2. Deploy the Docker Compose project using the built image
resource "docker_compose" "services_stack" {
  project_name = "api-services"
  config_paths = [
    "${path.module}/../../../docker-compose.yml"
  ]

  depends_on = [docker_image.services_image, docker_image.nginx_image]
}