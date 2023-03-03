resource "cloudflare_ruleset" "http_config_settings" {
  zone_id = cloudflare_zone.zone.id
  name    = "http_config_settings"
  kind    = "zone"
  phase   = "http_config_settings"

  rules {
    enabled     = true
    description = "Disable Content Modification"
    action      = "set_config"
    action_parameters {
      autominify {
        css  = false
        html = false
        js   = false
      }
      rocket_loader = false
    }

    expression = <<-EOT
      (http.host in {
        "apps.starry.blue"
        "asf.starry.blue"
        "jupyter.starry.blue"
      })
    EOT
  }
}
