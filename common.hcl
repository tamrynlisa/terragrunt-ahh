locals {
    original_dir = get_original_terragrunt_dir()
    repo_root = get_repo_root()
    root_path = replace(local.original_dir, local.repo_root, "")
    parsed_root_elements = split("/", local.root_path)
    root_elements = slice(local.parsed_root_elements, 1, length(local.parsed_root_elements))
    root_elements_count = length(local.root_elements)

    terraform_root = trimprefix(local.original_dir, "${local.repo_root}/")
    global_address_space = "${local.repo_root}/networking/global_address_space"

    # NOTE: This is debug output to troubleshoot root metadata parsing.
    #debug_root = [
    #    run_cmd("echo", "##### common.hcl -- root config"),
    #    run_cmd("echo", "local.original_dir           : ${jsonencode(local.original_dir)}"),
    #    run_cmd("echo", "local.repo_root              : ${jsonencode(local.repo_root)}"),
    #    run_cmd("echo", "local.root_path              : ${jsonencode(local.root_path)}"),
    #    run_cmd("echo", "local.parsed_root_elements   : ${jsonencode(local.parsed_root_elements)}"),
    #    run_cmd("echo", "local.root_elements          : ${jsonencode(local.root_elements)}"),
    #    run_cmd("echo", "local.root_elements_count    : ${jsonencode(local.root_elements_count)}"),
    #    run_cmd("echo", "local.terraform_root         : ${jsonencode(local.terraform_root)}"),
    #]

    # AWS roots format:        aws       /ACCOUNT_NAME/ENVIRONMENT/REGION/APPLICATION/COMPONENT/SUB-COMPONENTS...
    # Azure roots are:         azure     /SUBSCRIPTION/ENVIRONMENT/REGION/APPLICATION/COMPONENT/SUB-COMPONENTS...
    # Kubernetes roots format: kubernetes/CLUSTER     /ENVIRONMENT/APPLICATION/COMPONENT
    provider = local.root_elements[0]
    # Either AWS account, Azure subscription or Kubernetes cluster name
    account = local.root_elements[1]
    environment = local.root_elements[2]

    provider_root = "${get_repo_root()}/${local.provider}"
    account_root = "${local.provider_root}/${local.account}"

    environment_short = {
        infrastructure = "infra"
        development = "dev"
        production = "prod"
    }
    env_short = try(local.environment_short[local.environment], local.environment)

    # NOTE: This is debug output to troubleshoot root metadata parsing.
    #debug_provider = [
    #    run_cmd("echo", "##### common.hcl -- provider config"),
    #    run_cmd("echo", "local.provider          : ${jsonencode(local.provider)}"),
    #    run_cmd("echo", "local.account           : ${jsonencode(local.account)}"),
    #    run_cmd("echo", "local.environment       : ${jsonencode(local.environment)}"),
    #    run_cmd("echo", "local.env_short         : ${jsonencode(local.env_short)}"),
    #    run_cmd("echo", "local.provider_root     : ${jsonencode(local.provider_root)}"),
    #    run_cmd("echo", "local.account_root      : ${jsonencode(local.account_root)}"),
    #]
}
