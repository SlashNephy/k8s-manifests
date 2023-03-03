resource "cloudflare_access_application" "stella" {
  account_id                = cloudflare_account.account.id
  name                      = "stella"
  domain                    = cloudflare_record.cname_stella.hostname
  type                      = "self_hosted"
  app_launcher_visible      = true
  allowed_idps              = [cloudflare_access_identity_provider.github_oauth.id]
  auto_redirect_to_identity = true
  session_duration          = "24h"
}

resource "cloudflare_access_policy" "stella" {
  account_id     = cloudflare_account.account.id
  application_id = cloudflare_access_application.stella.id
  name           = "private"
  decision       = "allow"
  precedence     = 1

  include {
    group = [cloudflare_access_group.github_organization_private.id]
  }
}
