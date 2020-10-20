variable "deployment_environment" {
    default = "dev"
    description = "- (Required) Environment or namespace for application"
}

variable "deployment_name" {
  default = "food-market"
  default = "- (Required) The deployment name"
}

variable "deployment_endpoint" {
  default = {
      test = "test.market.bugdalorian.com"
      qa = "qa.market.bugdalorian.com"
      dev = "dev.market.bugdalorian.com"
      prod = "prod.market.bugdalorian.com"
  }
  description = "- (Required) application endpoint will be changed by environment name"
}


variable "deployment_image" {
  default = "nginx"
  description = "- (Required) Docker image location docker.fuchicorp.com"
}

