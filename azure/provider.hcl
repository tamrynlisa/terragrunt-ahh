locals {
    common = read_terragrunt_config(find_in_parent_folders("common.hcl"))

    # NOTE: Some things need to swap from the `global` region to a valid
    # region, so we set the default region centrally.
    default_region = "southafricanorth"

    # Azure roots are: azure/SUBSCRIPTION/ENVIRONMENT/REGION/APPLICATION/COMPONENT
    subscription = local.common.locals.account
    environment = local.common.locals.root_elements[2]
    region = local.common.locals.root_elements[3]
    application = local.common.locals.root_elements[4]
    component = length(local.common.locals.root_elements) >= 6 ? local.common.locals.root_elements[5] : ""

    subscription_root = local.common.locals.account_root
    environment_root = "${local.subscription_root}/${local.common.locals.environment}"
    region_root = "${local.environment_root}/${local.region}"
    application_root = "${local.region_root}/${local.application}"
    component_root = length(local.common.locals.root_elements) >= 6 ? "${local.application_root}/${local.component}" : ""

    global_azure_devops = "${local.subscription_root}/shared/global/azure_devops"

    # NOTE: This is debug output to troubleshoot root metadata parsing.
    #debug_root_data = [
    #    run_cmd("echo", "##### provider.hcl - root data config"),
    #    run_cmd("echo", "local.region                 : ${jsonencode(local.region)}"),
    #    run_cmd("echo", "local.application            : ${jsonencode(local.application)}"),
    #    run_cmd("echo", "local.component              : ${jsonencode(local.component)}"),
    #    run_cmd("echo", "local.environment_root       : ${jsonencode(local.environment_root)}"),
    #    run_cmd("echo", "local.region_root            : ${jsonencode(local.region_root)}"),
    #    run_cmd("echo", "local.application_root       : ${jsonencode(local.application_root)}"),
    #    run_cmd("echo", "local.component_root         : ${jsonencode(local.component_root)}"),
    #]

    # NOTE: The base root structure consists of 6 elements, meaning if
    # local.root_elements is longer than 7 are are sub components. We make no
    # assumptions about sub-components, so there could be an arbitrary number
    # of sub-components. Because of this we just pass them as a mapping of
    # their index to their value as well as a list.
    # NOTE: that the original list is 0 indexed, so the last element of the
    # standard 6 would be indexed as number 5.
    # NOTE: In the slice below, the number 5 is the start index, i.e. the 6th
    # element.
    sub_components_list = local.common.locals.root_elements_count <= 6 ? [] : slice(local.common.locals.root_elements, 6 , local.common.locals.root_elements_count)
    sub_components = {
        for i, v in local.sub_components_list: i => replace(v, "_", "-")
    }

    #debug_sub_components = [
    #    run_cmd("echo", "##### provider.hcl - sub coomponents config"),
    #    run_cmd("echo", "local.sub_components_list    : ${jsonencode(local.sub_components_list)}"),
    #    run_cmd("echo", "local.sub_components         : ${jsonencode(local.sub_components)}"),
    #]

    default_ad_owners = [

    ]

    # NOTE: Placeholder subscription configuration
    subscriptions = {
        "default" = {
            alias = "default"
            # name = "Kinetic Skunk Sponsored Subscription"
            name = "Azure for Students"
            # subscription_id = "63817644-bba0-4d70-a069-7de81cbd296e"
            subscription_id = "d4aed6b4-8573-4645-b7a3-3cf34177e822"
            # tenant_id = "d4a39087-ec22-44f5-9bb7-68b71271c26a"
            tenant_id = "cc6148eb-d356-4f38-900f-3a4d62b954c8"
        }
    }
    sub_data = local.subscriptions[local.subscription]

    #debug_sub_components = [
    #    run_cmd("echo", "##### provider.hcl - subscription config"),
    #    run_cmd("echo", "local.sub_data : ${jsonencode(local.sub_data)}"),
    #]

    # NOTE: These are the defaults for naming only.
    default_separator = "-"

    base_name_list = [
        replace(local.subscription, "_", local.default_separator),
        local.common.locals.environment,
        replace(local.application, "_", local.default_separator)
    ]
    base_name_compact = compact(local.base_name_list)
    base_name_joined = join(local.default_separator, local.base_name_compact)
    base_name = lower(local.base_name_joined)

    sa_base_name_list = [
        replace(local.subscription, "_", local.default_separator),
        local.common.locals.env_short,
        replace(local.application, "_", local.default_separator),
    ]
    sa_base_name_compact = compact(local.sa_base_name_list)
    sa_base_name_joined = join(local.default_separator, local.sa_base_name_compact)
    sa_base_name = lower(local.sa_base_name_joined)

    #debug_default_names = [
    #    run_cmd("echo", "##### provider.hcl - default naming config"),
    #    run_cmd("echo", "local.base_name_compact   : ${jsonencode(local.base_name_compact)}"),
    #    run_cmd("echo", "local.base_name_joined    : ${jsonencode(local.base_name_joined)}"),
    #    run_cmd("echo", "local.base_name           : ${jsonencode(local.base_name)}"),
    #    run_cmd("echo", "local.sa_base_name_list   : ${jsonencode(local.sa_base_name_list)}"),
    #    run_cmd("echo", "local.sa_base_name_compact: ${jsonencode(local.sa_base_name_compact)}"),
    #    run_cmd("echo", "local.sa_base_name_joined : ${jsonencode(local.sa_base_name_joined)}"),
    #    run_cmd("echo", "local.sa_base_name        : ${jsonencode(local.sa_base_name)}"),
    #]

    tfstate_subscription = local.sub_data.alias
    tfstate_environment = "infrastructure"
    tfstate_env_short = local.common.locals.environment_short[local.tfstate_environment]
    tfstate_application = "tfstate"
    state = {
        sub = local.sub_data
        rg = local.tfstate_rg
        sa = local.tfstate_sa
        container = "tfstate"
        key = "${local.common.locals.terraform_root}/terraform.tfstate"
    }

    tfstate_base_name_list = [
        replace(local.tfstate_subscription, "_", local.default_separator),
        local.tfstate_env_short,
        replace(local.tfstate_application, "_", local.default_separator)
    ]
    tfstate_base_name_compact = compact(local.tfstate_base_name_list)
    tfstate_base_name_joined = join(local.default_separator, local.tfstate_base_name_compact)
    tfstate_base_name = lower(local.tfstate_base_name_joined)

    tfstate_sa_base_name_list = [
        replace(local.tfstate_subscription, "_", local.default_separator),
        local.tfstate_env_short,
        replace(local.tfstate_application, "_", local.default_separator)
    ]
    tfstate_sa_base_name_compact = compact(local.tfstate_sa_base_name_list)
    tfstate_sa_base_name_joined = join("", local.tfstate_sa_base_name_compact)
    tfstate_sa_base_name = lower(local.tfstate_sa_base_name_joined)

    tfstate_rg = local.tfstate_base_name
    # NOTE: Storage account names are limited
    tfstate_sa = substr(replace(local.tfstate_sa_base_name, local.default_separator, ""), 0, 24)

    #debug_tfstate = [
    #    run_cmd("echo", "##### provider.hcl - tfstate config"),
    #    run_cmd("echo", "local.tfstate_subscription        : ${jsonencode(local.tfstate_subscription)}"),
    #    run_cmd("echo", "local.tfstate_environment         : ${jsonencode(local.tfstate_environment)}"),
    #    run_cmd("echo", "local.tfstate_env_short           : ${jsonencode(local.tfstate_env_short)}"),
    #    run_cmd("echo", "local.tfstate_application         : ${jsonencode(local.tfstate_application)}"),
    #    run_cmd("echo", "local.tfstate_rg                  : ${jsonencode(local.tfstate_rg)}"),
    #    run_cmd("echo", "local.tfstate_sa                  : ${jsonencode(local.tfstate_sa)}"),
    #    run_cmd("echo", "local.state                       : ${jsonencode(local.state)}"),
    #    run_cmd("echo", "local.tfstate_base_name_list      : ${jsonencode(local.tfstate_base_name_list)}"),
    #    run_cmd("echo", "local.tfstate_base_name_compact   : ${jsonencode(local.tfstate_base_name_compact)}"),
    #    run_cmd("echo", "local.tfstate_base_name_joined    : ${jsonencode(local.tfstate_base_name_joined)}"),
    #    run_cmd("echo", "local.tfstate_base_name           : ${jsonencode(local.tfstate_base_name)}"),
    #    run_cmd("echo", "local.tfstate_sa_base_name_list   : ${jsonencode(local.tfstate_sa_base_name_list)}"),
    #    run_cmd("echo", "local.tfstate_sa_base_name_compact: ${jsonencode(local.tfstate_sa_base_name_compact)}"),
    #    run_cmd("echo", "local.tfstate_sa_base_name_joined : ${jsonencode(local.tfstate_sa_base_name_joined)}"),
    #    run_cmd("echo", "local.tfstate_sa_base_name        : ${jsonencode(local.tfstate_sa_base_name)}"),
    #]
}

generate "provider" {
    path = "provider_azure.tf"
    if_exists = "overwrite"
    contents = <<EOF
terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">=3.30.0"
        }
        azuredevops = {
            source = "microsoft/azuredevops"
            version = ">=0.1.0"
        }
        azuread = {
            source  = "hashicorp/azuread"
            version = ">=2.15.0"
        }
    }
}

provider "azurerm" {
    skip_provider_registration = true
    features {
        key_vault {
            purge_soft_deleted_secrets_on_destroy = true
        }
    }
    tenant_id = "${local.sub_data.tenant_id}"
    subscription_id = "${local.sub_data.subscription_id}"
}

provider "azuredevops" {
    org_service_url = "https://dev.azure.com/kineticskunkITS/"
}
EOF
}

# remote_state {
#     backend = "azurerm"
#     generate = {
#         path      = "backend.tf"
#         if_exists = "overwrite_terragrunt"
#     }
#     config = {
#         tenant_id = local.state.sub.tenant_id
#         subscription_id = local.state.sub.subscription_id
#         resource_group_name  = local.state.rg
#         storage_account_name = local.state.sa
#         container_name = local.state.container
#         key =   local.state.key
#     }
# }

inputs = {
    base_name = local.base_name
    sa_base_name = local.sa_base_name
    default_separator = local.default_separator
    default_ad_owners = local.default_ad_owners
    component = local.component
    application = local.application
    region = local.region
    environment = local.common.locals.environment
    env_short = local.common.locals.env_short
    tags = {
        application = local.application
        environment = local.common.locals.environment
        terraform_managed = true
        terraform_root = "${local.common.locals.terraform_root}"
    }
}
