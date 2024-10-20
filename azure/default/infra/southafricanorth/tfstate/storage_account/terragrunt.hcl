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
    source = "${get_repo_root()}/src/azure//storage_account"
}

# dependency "rg" {
#     config_path = "${include.provider.locals.region_root}/reseource_group"
# }

# inputs = {
#     rg = dependency.rg.output.rg_name
#     location = dependency.location.rg_location
# }

# NOTE: Without this the root doesn't work.
generate = include.provider.generate
