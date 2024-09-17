locals {
    plan_output = "plan.out"
    tf_root = trimprefix(path_relative_to_include(), get_repo_root())
}

terraform {
  # Force Terraform to not ask for input value if some variables are undefined.
  extra_arguments "disable_input" {
    commands  = get_terraform_commands_that_need_input()
    arguments = ["-input=false"]
  }
  extra_arguments "locking" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = [
      "-lock-timeout=20m",
      "-lock=true"
    ]
  }
  extra_arguments "create_plan_out" {
    commands  = [
      "plan"
    ]
    arguments = [
      "-out=${local.plan_output}"
    ]
  }
  extra_arguments "use_plan_out" {
    commands  = [
      "apply"
    ]
    arguments = [
      "${local.plan_output}"
    ]
  }
}
