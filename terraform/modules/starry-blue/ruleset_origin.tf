resource "cloudflare_ruleset" "origin" {
  zone_id = local.cloudflare_zone_id
  name    = "Use :8443 Origin"
  kind    = "zone"
  phase   = "http_request_origin"

  rules {
    enabled = true
    action  = "route"
    action_parameters {
      origin {
        port = 8443
      }
    }

    # TODO: 不要なホストを削除する
    expression = <<-EOT
      (http.host in {
        "anemos.starry.blue"
        "apps.starry.blue"
        "argocd.starry.blue"
        "asf.starry.blue"
        "atmos.starry.blue"
        "basic.starry.blue"
        "epgstation.starry.blue"
        "files.starry.blue"
        "jupyter.starry.blue"
        "k8s.starry.blue"
        "konomitv.starry.blue"
        "mirakurun.starry.blue"
        "owncast.starry.blue"
        "rustpad.starry.blue"
        "search.starry.blue"
        "stella.starry.blue"
        "traefik.starry.blue"
        "whoami.starry.blue"
        "wol.starry.blue"
      })
    EOT
  }
}
