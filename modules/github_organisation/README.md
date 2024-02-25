# github_user

Configures user ssh&pgp keys for the given access token.

## Requirements

* `GITHUB_TOKEN`: Provider populates github token from environment variables.

## Sample Variables

```yaml
github_access_token: '........'
ssh_keys:
    main:
        title: 'Main ssh key'
        key: '.........'
    backup:
        title: 'Backup ssh key'
        key: '.........'
gpg_keys:
    main: '..........'
    backup: '....'
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_organization_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_permissions) | resource |
| [github_branch_default.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_issue_labels.issue_labels](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_labels) | resource |
| [github_membership.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) | resource |
| [github_organization_block.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_block) | resource |
| [github_organization_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |
| [github_repository_file.codeowners](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.init_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_members.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) | resource |
| [github_team_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_permissions"></a> [action\_permissions](#input\_action\_permissions) | Github Actions Organisational Level Permissions | <pre>object({<br>    allowed_actions      = optional(string, "selected")<br>    enabled_repositories = optional(string, "all")<br>    github_owned_allowed = optional(bool, true)<br>    patterns_allowed     = optional(list(string), [])<br>    verified_allowed     = optional(bool, false)<br>  })</pre> | n/a | yes |
| <a name="input_blocked_users"></a> [blocked\_users](#input\_blocked\_users) | List of users blocked by organisation | `list(string)` | `[]` | no |
| <a name="input_members"></a> [members](#input\_members) | Organisation members | <pre>map(object({<br>    role  = string<br>    teams = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| <a name="input_organisation"></a> [organisation](#input\_organisation) | Organisation Settings | <pre>object({<br>    name                                                         = string<br>    company                                                      = string<br>    description                                                  = string<br>    email                                                        = optional(string, "")<br>    billing_email                                                = string<br>    blog                                                         = optional(string, "")<br>    twitter_username                                             = optional(string, "")<br>    location                                                     = optional(string, "")<br>    has_organization_projects                                    = optional(bool, false)<br>    has_repository_projects                                      = optional(bool, false)<br>    default_repository_permission                                = optional(string, "read")<br>    members_can_create_repositories                              = optional(bool, false)<br>    members_can_create_public_repositories                       = optional(bool, false)<br>    members_can_create_private_repositories                      = optional(bool, false)<br>    members_can_create_internal_repositories                     = optional(bool, false)<br>    members_can_create_pages                                     = optional(bool, false)<br>    members_can_create_public_pages                              = optional(bool, false)<br>    members_can_create_private_pages                             = optional(bool, false)<br>    members_can_fork_private_repositories                        = optional(bool, false)<br>    web_commit_signoff_required                                  = optional(bool, true)<br>    advanced_security_enabled_for_new_repositories               = optional(bool, true)<br>    dependabot_alerts_enabled_for_new_repositories               = optional(bool, true)<br>    dependabot_security_updates_enabled_for_new_repositories     = optional(bool, true)<br>    dependency_graph_enabled_for_new_repositories                = optional(bool, true)<br>    secret_scanning_enabled_for_new_repositories                 = optional(bool, true)<br>    secret_scanning_push_protection_enabled_for_new_repositories = optional(bool, true)<br>  })</pre> | n/a | yes |
| <a name="input_provisioner"></a> [provisioner](#input\_provisioner) | Provisioner User Configuration. | <pre>object({<br>    managed_by_text = string<br>    user            = string<br>    email           = string<br>  })</pre> | n/a | yes |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | Organisation Repositories | <pre>list(object({<br>    name                        = string<br>    description                 = string<br>    visibility                  = optional(string, "public")<br>    has_issues                  = optional(bool, false)<br>    has_downloads               = optional(bool, false)<br>    has_discussions             = optional(bool, false)<br>    has_projects                = optional(bool, false)<br>    has_wiki                    = optional(bool, false)<br>    is_template                 = optional(bool, false)<br>    allow_update_branch         = optional(bool, false)<br>    allow_merge_commit          = optional(bool, false)<br>    allow_squash_merge          = optional(bool, true)<br>    allow_rebase_merge          = optional(bool, true)<br>    allow_auto_merge            = optional(bool, false)<br>    archived                    = optional(bool, false)<br>    delete_branch_on_merge      = optional(bool, true)<br>    default_branch              = optional(string, "main")<br>    homepage_url                = optional(string, "")<br>    topics                      = optional(list(string), [])<br>    web_commit_signoff_required = optional(bool, true)<br>    issue_labels                = optional(map(string), {})<br>    status_checks               = optional(list(string), [])<br>    files                       = map(string)<br>    codeowners                  = optional(string, "")<br>  }))</pre> | `[]` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | Map of teams created for the organisation | <pre>map(object({<br>    description              = string<br>    privacy                  = string<br>    admin                    = optional(bool, false)<br>    security                 = optional(bool, false)<br>    pr_member_count          = optional(number, 1)<br>    pr_notification          = optional(bool, true)<br>    repo_permission          = optional(string, "read")<br>    repo_permission_override = optional(map(string), {})<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_members"></a> [members](#output\_members) | Organisation members |
| <a name="output_orgname"></a> [orgname](#output\_orgname) | Organisation name to use in dependent deployments |
| <a name="output_repositories"></a> [repositories](#output\_repositories) | Repositories |
| <a name="output_teams"></a> [teams](#output\_teams) | Teams with github identifiers |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
