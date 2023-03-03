resource "cloudflare_access_application" "search" {
  account_id                = cloudflare_account.account.id
  name                      = "ksearch"
  domain                    = cloudflare_record.cname_search.hostname
  type                      = "self_hosted"
  app_launcher_visible      = true
  allowed_idps              = [cloudflare_access_identity_provider.github_oauth.id]
  auto_redirect_to_identity = true
  session_duration          = "24h"
}

resource "cloudflare_access_policy" "search" {
  account_id     = cloudflare_account.account.id
  application_id = cloudflare_access_application.search.id
  name           = "org"
  decision       = "allow"
  precedence     = 1

  include {
    group = [cloudflare_access_group.github_organization.id]
  }
}
