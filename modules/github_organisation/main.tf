locals {
  default_branch = "main"
  repositories   = { for repo in var.repositories : repo.name => repo }

  init_files = flatten([
    for repo_name, repo in local.repositories : [
      for file_name, path in repo.files : {
        key  = "${repo_name}_${file_name}"
        repo = repo_name
        name = file_name
        path = path
      }
    ]
  ])
}

resource "github_organization_settings" "this" {
  name                                                         = var.organisation.name
  company                                                      = var.organisation.company
  description                                                  = var.organisation.description
  email                                                        = var.organisation.email
  billing_email                                                = var.organisation.billing_email
  blog                                                         = var.organisation.blog
  twitter_username                                             = var.organisation.twitter_username
  location                                                     = var.organisation.location
  has_organization_projects                                    = var.organisation.has_organization_projects
  has_repository_projects                                      = var.organisation.has_repository_projects
  default_repository_permission                                = var.organisation.default_repository_permission
  members_can_create_repositories                              = var.organisation.members_can_create_repositories
  members_can_create_public_repositories                       = var.organisation.members_can_create_public_repositories
  members_can_create_private_repositories                      = var.organisation.members_can_create_private_repositories
  members_can_create_internal_repositories                     = var.organisation.members_can_create_internal_repositories
  members_can_create_pages                                     = var.organisation.members_can_create_pages
  members_can_create_public_pages                              = var.organisation.members_can_create_public_pages
  members_can_create_private_pages                             = var.organisation.members_can_create_private_pages
  members_can_fork_private_repositories                        = var.organisation.members_can_fork_private_repositories
  web_commit_signoff_required                                  = var.organisation.web_commit_signoff_required
  advanced_security_enabled_for_new_repositories               = var.organisation.advanced_security_enabled_for_new_repositories
  dependabot_alerts_enabled_for_new_repositories               = var.organisation.dependabot_alerts_enabled_for_new_repositories
  dependabot_security_updates_enabled_for_new_repositories     = var.organisation.dependabot_security_updates_enabled_for_new_repositories
  dependency_graph_enabled_for_new_repositories                = var.organisation.dependency_graph_enabled_for_new_repositories
  secret_scanning_enabled_for_new_repositories                 = var.organisation.secret_scanning_enabled_for_new_repositories
  secret_scanning_push_protection_enabled_for_new_repositories = var.organisation.secret_scanning_push_protection_enabled_for_new_repositories
}

resource "github_actions_organization_permissions" "this" {
  allowed_actions      = var.action_permissions.allowed_actions
  enabled_repositories = var.action_permissions.enabled_repositories

  allowed_actions_config {
    github_owned_allowed = var.action_permissions.github_owned_allowed
    patterns_allowed     = var.action_permissions.patterns_allowed
    verified_allowed     = var.action_permissions.verified_allowed
  }
}

resource "github_organization_block" "this" {
  for_each = toset(var.blocked_users)
  username = each.key
}

resource "github_team" "this" {
  for_each    = var.teams
  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

resource "github_team_settings" "this" {
  for_each = var.teams
  team_id  = github_team.this[each.key].id
  review_request_delegation {
    algorithm    = "LOAD_BALANCE"
    member_count = each.value.pr_member_count
    notify       = each.value.pr_notification
  }
}

resource "github_membership" "this" {
  for_each = var.members
  username = each.key
  role     = each.value.role
}

resource "github_team_members" "this" {
  for_each = var.teams
  team_id  = github_team.this[each.key].id

  dynamic "members" {
    for_each = { for name, user in var.members : name => user.role if try(user.teams[0], "") == "*" || contains(user.teams, each.key) }
    content {
      username = members.key
      role     = members.value == "admin" ? "maintainer" : "member"
    }
  }
}


resource "github_repository" "this" {
  for_each                    = local.repositories
  name                        = each.value.name
  description                 = each.value.description
  homepage_url                = each.value.homepage_url
  visibility                  = each.value.visibility
  has_issues                  = each.value.has_issues
  has_downloads               = each.value.has_downloads
  has_discussions             = each.value.has_discussions
  has_projects                = each.value.has_projects
  has_wiki                    = each.value.has_wiki
  is_template                 = each.value.is_template
  allow_update_branch         = each.value.allow_update_branch
  allow_merge_commit          = each.value.allow_merge_commit
  allow_squash_merge          = each.value.allow_squash_merge
  allow_rebase_merge          = each.value.allow_rebase_merge
  allow_auto_merge            = each.value.allow_auto_merge
  delete_branch_on_merge      = each.value.delete_branch_on_merge
  archived                    = each.value.archived
  web_commit_signoff_required = each.value.web_commit_signoff_required
  topics                      = each.value.topics
  auto_init                   = true
  vulnerability_alerts        = true

  dynamic "security_and_analysis" {
    for_each = each.value.visibility == "public" ? [1] : []
    content {
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "enabled"
      }
    }
  }
}

resource "github_branch_protection" "this" {
  for_each      = { for name, repo in local.repositories : name => repo if repo.visibility == "public" }
  repository_id = github_repository.this[each.key].node_id

  pattern                 = coalesce(each.value.default_branch, local.default_branch)
  enforce_admins          = false
  allows_deletions        = false
  require_signed_commits  = true
  required_linear_history = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    dismissal_restrictions          = []
    pull_request_bypassers          = []
    require_code_owner_reviews      = true
    require_last_push_approval      = false
    required_approving_review_count = 1
    restrict_dismissals             = false
  }
  required_status_checks {
    contexts = each.value.status_checks
    strict   = true
  }
  depends_on = [github_repository.this]
}


resource "github_branch_default" "main" {
  for_each   = local.repositories
  repository = each.key
  branch     = coalesce(each.value.default_branch, local.default_branch)
  depends_on = [github_repository.this]
}


resource "github_issue_labels" "issue_labels" {
  for_each   = { for name, repo in local.repositories : name => repo.repository.issue_labels if length(repo.issue_labels) > 0 }
  repository = each.key

  dynamic "label" {
    for_each = each.value
    content {
      name  = label.key
      color = label.value
    }
  }
  depends_on = [github_repository.this]
}

resource "github_repository_file" "init_files" {
  for_each            = { for init_file in local.init_files : init_file.key => init_file }
  repository          = each.value.repo
  branch              = github_branch_default.main[each.value.repo].branch
  file                = each.value.name
  content             = file(each.value.path)
  commit_message      = var.provisioner.managed_by_text
  commit_author       = var.provisioner.user
  commit_email        = var.provisioner.email
  overwrite_on_create = true
  depends_on          = [github_branch_default.main]
}

resource "github_repository_file" "codeowners" {
  for_each            = { for repo_name, repo in local.repositories : repo_name => repo.codeowners if repo.codeowners != "" }
  repository          = each.key
  branch              = github_branch_default.main[each.key].branch
  file                = ".github/CODEOWNERS"
  content             = each.value
  commit_message      = var.provisioner.managed_by_text
  commit_author       = var.provisioner.user
  commit_email        = var.provisioner.email
  overwrite_on_create = true
  depends_on          = [github_branch_default.main]
}

resource "github_repository_collaborators" "this" {
  for_each   = local.repositories
  repository = each.key

  dynamic "team" {
    for_each = var.teams
    content {
      permission = coalesce(try(team.value.repo_permission_override[each.key], null), team.value.repo_permission)
      team_id    = team.key
    }
  }

  depends_on = [github_team.this, github_repository.this]
}
