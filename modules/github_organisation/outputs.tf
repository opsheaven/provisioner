output "orgname" {
  description = "Organisation name to use in dependent deployments"
  value       = var.organisation.company
}

output "teams" {
  description = "Teams with github identifiers"
  value = {
    for name, team in var.teams : name => github_team.this[name].id
  }
}

output "members" {
  description = "Organisation members"
  value       = keys(var.members)
}

output "repositories" {
  description = "Repositories"
  value       = [for repo in var.repositories : repo.name]
}
