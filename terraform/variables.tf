variable "render_api_key" {
  description = "Clé API Render"
  type        = string
  sensitive   = true
}

variable "render_owner_id" {
  description = "Owner ID Render"
  type        = string
  sensitive   = true
}

variable "ghcr_username" {
  description = "Nom d'utilisateur GitHub"
  type        = string
}

variable "ghcr_token" {
  description = "Token GitHub pour GHCR"
  type        = string
  sensitive   = true
}

variable "image_tag" {
  description = "Tag de l'image Docker"
  type        = string
  default     = "latest"
}

variable "render_region" {
  description = "Région Render"
  type        = string
  default     = "frankfurt"
}