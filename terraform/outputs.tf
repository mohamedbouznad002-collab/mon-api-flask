output "url_application" {
  description = "URL publique de l'application sur Render"
  value       = "https://${render_web_service.api_flask.slug}.onrender.com"
}

output "service_id" {
  description = "ID du service Render"
  value       = render_web_service.api_flask.id
}