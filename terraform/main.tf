terraform {
  required_version = ">= 1.9.0"
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.3"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

resource "render_web_service" "api_flask" {
  name   = "mon-api-flask"
  region = var.render_region
  plan   = "free"

  runtime_source = {
    image = {
      image_url = "ghcr.io/${var.ghcr_username}/mon-api-flask"
      tag       = var.image_tag
      credentials = {
        username              = var.ghcr_username
        personal_access_token = var.ghcr_token
      }
    }
  }

  env_vars = {
    PORT = {
      value = "5000"
    }
    FLASK_ENV = {
      value = "production"
    }
  }

  disk = null
}