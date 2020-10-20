module "isitup-deploy" {
  source  = "fuchicorp/chart/helm"

  deployment_name        = "isitup"
  deployment_environment = "${var.deployment_environment}"
  deployment_endpoint    = "${lookup(var.deployment_endpoint, "${var.deployment_environment}")}.${var.google_domain_name}" 
  deployment_path        = "isitup"

  template_custom_vars  = {     
    deployment_image     = "${var.deployment_image}"    
  }
}
