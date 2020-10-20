module "sonarqube_deploy" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "sonarqube"
  deployment_environment = "${kubernetes_namespace.service_tools.metadata.0.name}"
  deployment_endpoint    = "sonarqube.${var.google_domain_name}"
  deployment_path        = "sonarqube"

  template_custom_vars = {

    null_depends_on      = "${null_resource.cert_manager.id}"
    sonarqube_ip_ranges  =  "${var.common_tools["ip_ranges"]}"
  }
}

  resource "kubernetes_secret" "sonarqube-admin-access" {
   metadata {
    name = "sonarqube-admin-access"
    namespace = "tools"
    annotations {
        "jenkins.io/credentials-description" = "Sonarqube Creds"
    }
    labels {
        "jenkins.io/credentials-type" = "usernamePassword"
    }
  }

  data = {
    "username" = "${var.sonarqube["username"]}"
    "password" = "${var.sonarqube["admin_password"]}"
  }
 }