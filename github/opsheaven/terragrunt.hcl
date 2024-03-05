terraform {
  source = "tfr:///opsheaven/organisation/github?version=0.1.1"
}

include {
  path = find_in_parent_folders()
}

inputs = merge(
  yamldecode(file("config.yaml")),
  {
    teams   = yamldecode(file("teams.yaml"))
    members = yamldecode(file("members.yaml"))
    repositories = merge([
      for f in fileset("${get_terragrunt_dir()}/repositories", "*.yaml") : yamldecode(file("${get_terragrunt_dir()}/repositories/${f}"))
      ]...
    )
  }
)

generate "moved" {
  path      = "moved.tf"
  if_exists = "overwrite"
  contents  = <<EOT
  moved {
    from = github_branch_default.main["terraform-hetzner-zone"]
    to = github_branch_default.main["terraform-hetzner-hetzner-zone"]
  }
  moved {
    from =  github_repository.this["terraform-hetzner-zone"]
    to =  github_repository.this["terraform-hetzner-hetzner-zone"]
  }
  moved {
    from = github_repository_collaborators.this["terraform-hetzner-zone"]
    to =github_repository_collaborators.this["terraform-hetzner-hetzner-zone"]
  }
  moved {
    from = github_branch_protection.this["terraform-hetzner-zone"]
    to =github_branch_protection.this["terraform-hetzner-hetzner-zone"]
  }
EOT
}
