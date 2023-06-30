resource "cloudflare_record" "cname_apps" {
  zone_id = cloudflare_zone.zone.id
  name    = "apps"
  value   = cloudflare_record.a_gateway.hostname
  type    = "CNAME"
  proxied = true
}

resource "mackerel_service" "apps" {
  name = "apps-starry-blue"
}

resource "mackerel_monitor" "apps" {
  name = format("%s に疎通できない", cloudflare_record.cname_apps.hostname)

  external {
    method                 = "GET"
    url                    = format("https://%s", cloudflare_record.cname_apps.hostname)
    service                = mackerel_service.apps.name
    response_time_warning  = 500
    response_time_critical = 1000
    response_time_duration = 3
    max_check_attempts     = 1
    headers                = {
      Cache-Control = "no-cache"
    }
    certification_expiration_warning  = 30
    certification_expiration_critical = 15
    follow_redirect                   = false
  }
}
