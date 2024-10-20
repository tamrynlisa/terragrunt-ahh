include {
    path = find_in_parent_folders()
}

include "provider" {
    path = find_in_parent_folders("provider.hcl")
    expose = true
    merge_strategy = "deep"
}

include "common" {
    path = find_in_parent_folders("common.hcl")
    expose = true
    merge_strategy = "deep"
}

terraform {
    source = "${get_repo_root()}/src/azure//app_service_plan"
}

# NOTE: Without this the root doesn't work.
generate = include.provider.generate
