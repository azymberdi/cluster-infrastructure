module "academy-deploy" {
  source  = "fuchicorp/chart/helm"
  deployment_name        = "${var.deployment_name}"
  deployment_environment = "${var.deployment_environment}"
  deployment_endpoint    = "${lookup(var.deployment_endpoint, "${var.deployment_environment}")}"
  deployment_path        = "food-market"

  template_custom_vars  = {     
    deployment_image     = "${var.deployment_image}"    
  }
}