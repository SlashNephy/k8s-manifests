resource "cloudflare_access_application" "mirakurun" {
  account_id                = local.cloudflare_account_id
  name                      = "Mirakurun"
  domain                    = "mirakurun.starry.blue"
  type                      = "self_hosted"
  logo_url                  = "https://i.scdn.co/image/ab67616d0000b27353459416a76d3c403e2b1176"
  app_launcher_visible      = true
  allowed_idps              = [cloudflare_access_identity_provider.github_oauth.id]
  auto_redirect_to_identity = true
  session_duration          = "24h"
}

resource "cloudflare_access_policy" "mirakurun" {
  account_id     = local.cloudflare_account_id
  application_id = cloudflare_access_application.mirakurun.id
  name           = "private-dtv"
  decision       = "allow"
  precedence     = 0

  include {
    group = [cloudflare_access_group.github_organization_private_dtv.id]
  }
}
