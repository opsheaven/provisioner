remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    path = "${get_repo_root()}/state/${path_relative_to_include()}.state"
  }
}

inputs = merge(
  yamldecode(file("globals.yaml"))
)
