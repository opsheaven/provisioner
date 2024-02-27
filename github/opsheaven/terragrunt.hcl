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
