terraform {
  source = "tfr:///opsheaven/hetzner-zone/hetzner?version=0.1.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  zone = {
    name = "pinchflat.dev"
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
      default = {
        name  = "@"
        type  = "A"
        value = "34.149.66.123"
      }
      spf = {
        name  = "@"
        type  = "TXT"
        value = "v=spf1 include:_spf.google.com ~all"
      }
    }
  }
}
