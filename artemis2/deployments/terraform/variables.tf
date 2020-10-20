variable "deployment_endpoint" {
  type = "map"

  default = {
    test  = "test.artemis"
    dev  = "dev.artemis"
    qa   = "qa.artemis"
    prod = "artemis"
    stage = "stage.artemis"
  }
}

variable "deployment_image" {
  default = "fuchicorp.com/artemis"
}

variable "deployment_environment" {
  default = "dev"
}

variable "google_domain_name" {
  default = "fuchicorp.com"
}


