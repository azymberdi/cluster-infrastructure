variable "deployment_endpoint" {
  type = "map"

  default = {
    test  = "test.isitup"
    dev  = "dev.isitup"
    qa   = "qa.isitup"
    prod = "isitup"
    stage = "stage.isitup"
  }
}

variable "deployment_image" {
  default = "fuchicorp.com/isitup"
}

variable "deployment_environment" {
  default = "dev"
}

variable "google_domain_name" {
  default = "fuchicorp.com"
}
