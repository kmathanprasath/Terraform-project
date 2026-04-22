variable "app" {
  description = "Defining vm_app_1 and vm_app_2"
  type = map(object({
    tags               = map(string)
    key_name           = string
    enable_remote_exec = bool
  }))

  default = {
    "vm_app_1" = {
      tags               = { Name = "vm_app_1", Deployment_mode = "Terraform" }
      key_name           = "vm_app_1"
      enable_remote_exec = false
    }
    "vm_app_2" = {
      tags               = { Name = "vm_app_2", Deployment_mode = "Terraform" }
      key_name           = "vm_app_2"
      enable_remote_exec = false
    }
  }
}
