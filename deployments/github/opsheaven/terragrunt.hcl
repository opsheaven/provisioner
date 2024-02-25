terraform {
  source = "${get_repo_root()}//modules/github_organisation"
}

include {
  path = find_in_parent_folders()
}

locals {
  org_vars      = merge([for config_file in fileset(get_terragrunt_dir(), "*.yaml") : yamldecode(file(config_file))]...)
  status_checks = yamldecode(file("${get_terragrunt_dir()}/shared/status_checks.yaml"))
  repo_config = [
    for repository_config in fileset(get_terragrunt_dir(), "repositories/*/config.yaml") : yamldecode(file(repository_config))
  ]
  repo_vars = [
    for repo in local.repo_config : merge(
      repo,
      {
        files = merge(
          {
            for file in fileset("${get_terragrunt_dir()}/shared/files", "**") : file => "${get_terragrunt_dir()}/shared/files/${file}"
          },
          {
            for file in fileset("${get_terragrunt_dir()}/repositories/${repo.name}/files", "**") : file => "${get_terragrunt_dir()}/repositories/${repo.name}/files/${file}"
          }
        )
        status_checks = concat(
          try(repo.status_checks, []),
          local.status_checks
        )
        codeowners = templatefile("shared/CODEOWNERS", {
          CODEOWNERS = fileexists("repositories/${repo.name}/CODEOWNERS") ? file("repositories/${repo.name}/CODEOWNERS") : ""
        })
      }
    )
  ]
}

inputs = merge(
  local.org_vars,
  {
    repositories = local.repo_vars
  }
)
