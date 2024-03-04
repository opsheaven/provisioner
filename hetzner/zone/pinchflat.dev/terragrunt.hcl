terraform {
  source = "tfr:///opsheaven/zone/hetzner?version=0.0.1"
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
      catch_all_record = {
        name  = "@"
        type  = "A"
        value = "34.149.66.123"
      }
      nregistry = {
        name  = "nregistry"
        type  = "A"
        value = "34.149.66.123"
      }
      nwww = {
        name  = "nwww"
        type  = "A"
        value = "34.149.66.123"
      }
      registry = {
        name  = "registry"
        type  = "A"
        value = "34.149.66.123"
      }
      www = {
        name  = "www"
        type  = "CNAME"
        value = "pfltdv.github.io"
      }
      spf = {
        name  = "@"
        type  = "TXT"
        value = "v=spf1 include:_spf.google.com ~all"
      }
      google_domainkey_dkim1 = {
        name  = "@"
        type  = "TXT"
        value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtG74x8K9MtnRwWl0mZPBiMX5piONDQFdr9qc4nLrzQoUGn9INADpKlmPmkwN6lgoSWmeuPMFgjG7VhIdT4D8hQ+fSAKXlFCViV6i3Ze+b4uOEtiCQMhv+1Sj6M/VR+EstOUlxu6SW/tKRpJGgcpGDiGeJaCFcdw3esDBHmnjS6IcijqVbxO++i2r9LsZx4K/V AbZmeVwXwL9Ks9trJm0K8Ep3N1vZk+y3CDJ1ge5qIaYoy6BsGU69zmcnV6TXOEPF95cQaGKplCoX1y7nxR03Whr+GgRNFeGNflwKgdnxwfx1/ngF/JbxX5m3vsbOZdYSC2duFIkAETrcqkWyZzzRwIDAQAB"
      }
    }
  }
}
