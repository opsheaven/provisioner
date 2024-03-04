terraform {
  source = "tfr:///opsheaven/zone/hetzner?version=0.0.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  zone = {
    name = "opsheaven.space"
    ttl  = 3600
    records = {
      goggle_mx_1 = {
        name  = "@"
        type  = "MX"
        value = "1 ASPMX.L.GOOGLE.COM."
      }
      goggle_mx_2 = {
        name  = "@"
        type  = "MX"
        value = "5 ALT1.ASPMX.L.GOOGLE.COM."
      }
      goggle_mx_3 = {
        name  = "@"
        type  = "MX"
        value = "5 ALT2.ASPMX.L.GOOGLE.COM."
      }
      goggle_mx_4 = {
        name  = "@"
        type  = "MX"
        value = "10 ALT3.ASPMX.L.GOOGLE.COM."
      }
      goggle_mx_5 = {
        name  = "@"
        type  = "MX"
        value = "10 ALT4.ASPMX.L.GOOGLE.COM."
      }
      default_record = {
        name  = "@"
        type  = "A"
        value = "66.96.162.144"
      }
      catch_all_record = {
        name  = "*"
        type  = "A"
        value = "66.96.162.144"
      }
      storage = {
        name  = "storage"
        type  = "CNAME"
        value = "u393136.your-storagebox.de."
      }
      google_verification = {
        name  = "@"
        type  = "TXT"
        value = "google-site-verification=qBU88G79iX9-YzmaN29VumTcJCcsIyoVFMnl9mX-Jtc"
      }
      google_recovery_domain_verification = {
        name  = "@"
        type  = "TXT"
        value = "google-gws-recovery-domain-verification=49792331"
      }
      github_challenge = {
        name  = "_github-challenge-opsheaven-org"
        type  = "TXT"
        value = "_github-challenge-opsheaven-org		IN	TXT	5d93525144"
      }
    }
  }
}
