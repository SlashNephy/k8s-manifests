resource "cloudflare_record" "cname_rustpad" {
  zone_id = cloudflare_zone.zone.id
  name    = "rustpad"
  value   = cloudflare_record.a_gateway.hostname
  type    = "CNAME"
  proxied = true
}

resource "mackerel_service" "rustpad" {
  name = "Lily_rustpad"
}

resource "mackerel_monitor" "rustpad" {
  name = format("%s に疎通できない", cloudflare_record.cname_rustpad.hostname)

  external {
    method                 = "GET"
    url                    = format("https://%s", cloudflare_record.cname_rustpad.hostname)
    service                = mackerel_service.rustpad.name
    response_time_warning  = 3000
    response_time_critical = 5000
    response_time_duration = 3
    max_check_attempts     = 1
    headers                = {
      Cache-Control = "no-cache"
    }
    certification_expiration_warning  = 7
    certification_expiration_critical = 3
    follow_redirect                   = false
  }
}
