locals {
    settings_file = file("yaml-files/cognito.yaml") 
    settings_newbrand_file = file("yaml-files/newbrand.yaml") 
    settings = yamldecode(file("yaml-files/cognito.yaml"))
    settings_newbrand = yamldecode(file("yaml-files/newbrand.yaml")) 
    settings_cognito = local.settings["cognito"]
    settings_newbrand1 = local.settings_newbrand["newbrand"]
    merged1 = merge(local.settings, local.settings_newbrand)
    # files = [ for f in fileset("yaml-files", "*.yaml") ]
    settings1 = [ for f in fileset("yaml-files", "*.yaml") : yamldecode(f) ]
    merged_files = yamldecode(data.utils_deep_merge_yaml.example.output)
}

data "utils_deep_merge_yaml" "example" {
    input = [ for f in fileset("yaml-files", "*.yaml") : file("./yaml-files/${f}") ]
}

output "deep_merge_output" {
  value = yamldecode(data.utils_deep_merge_yaml.example.output)
}

terraform {
  required_version = ">= 1.0.8"
}

terraform {
  required_providers {
    utils = {
      source = "cloudposse/utils"
      version = ">= 0.3.0"
    }
  }
}