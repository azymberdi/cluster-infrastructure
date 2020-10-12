THE COMMON_TOOLS DEPLOYMENT STEPS

Prerequisites:

Before the starting deployment steps, please configure the following prerequisites to enable deploying processes.

Click " https://github.com/fuchicorp/cluster-infrastructure/wiki/cluster-infrastructure--set-env.sh."

After complete, the cluster-infrastructure deployment process following steps contains how to deploy common_tools to Kubernetes Cluster.

Required Packages

terraform v1.14
kubectl (configured )
helm v2.11.0
Cert-manager v0.11.0
Kube Cluster 1.12.7-gke.10
A - THE STEPS OF CONFIGURATION:

Clone the repository from GitHub
`git clone https://github.com/fuchicorp/common_tools.git`
`cd common_tools`
Please use the default module just run following command.

Create common_tools inside the common_tools.tfvars file and change bucket name, domain name, google project id, vault token change to yours, credentials should be common-service -account.json

To obtain the credentials go to GitHub and click to: a. Settings b. Developer settings c. OAuth AppsPersonal access tokens d .You have to generate token for Jenkins, Kubernetes, Grafana etc... Register a new OAuth application: Application Name: Jenkins HomePage URL: add your domain name for example:https://jenkins.fuchicorp.com Authorization callback URL: https://jenkins.fuchicorp.com/login

Configure the common_tools.tfvars file

environment = "tools"
google_bucket_name = "put your bucket name"
deployment_name = "common_tools"
google_project_id = "project id from google cloud platform"
google_domain_name = "your domain name"
vault_token = ""
credentials = "name of your xxxxx.json file"
deployment_environment = "tools"
jenkins = {
  admin_user             = ""
  admin_password         = ""
  jenkins_auth_client_id = "from Github Client ID"
  jenkins_auth_secret    = "Client Secret"
  git_token = "token from GitHub "
}
grafana = {
  grafana_username                = ""
  grafana_password                = ""
  grafana-name                    = ""
  grafana_auth_client_id          = ""
  grafana_client_secret           = ""
  smtp_username                   = ""
  smtp_password                   = ""
}
kube_dashboard = {
  github_auth_client_id = ""
  github_auth_secret    = ""
  github_organization   = ""
  proxy_cookie_secret   = ""
}

The name servers that respond to DNS queries for this domain. Your DNS and cluster/cloud DNS (name servers) should be matched for connection. if you use Route53, you have to check and edit your name servers.
   Check and make sure the name servers are matched with your current cluster/cloud DNS 
     a) Check Registered Domains Name servers
     b) Hosted Zones and put one of your name servers inside the start of authority (SOA) record. 
IP whitelisting is a security feature often used for limiting and controlling access only to trusted users. IP whitelisting allows you to create lists of trusted IP addresses or IP ranges from which your users can access your domains.
The Steps of Whitelisting for configuring Vault, Sonarqube, Prometheus, etc..:

Have to edit and add IPs to the following files:

a. common_tools.tfvars
b. variable.tf 
c. google_k8s_service_vault.tf`and `google_k8s_sonarqube_module.tf in the charts
For you to Whitelist IP's on any application, you would have to follow these steps:

a) git clone `[the common_tools]` link for it  https://github.com/fuchicorp/common_tools
If you have already on your local make sure it's on master and latest changes

b) Open your `common_tools.tfvars` and add the following line
B - THE STEPS OF EDITING AND DEPLOYMENT PROCESS:

To be able to access the Application. We have followed the next steps and commands:

Clone common_tools repository or pull the last changes if you already have your repo into your system.
Edit file common_tools.tfvars and specify the IP addresses.
common_tools = {
  ip_ranges = "10.40.0.13/8, 50.194.68.229/32, 50.194.68.230/32, 50.194.68.237/32, 24.12.115.204/32, 174.192.147.85/32, 71.73.65.46/32, 71.73.65.46/32"
}
https://isitup.fuchicorp.com/services/yourdomain.com
https://grafana.yourdomain.com/login
https://nexus.yourdomain.com
https://prometheus.yourdomain.com/graph
https://dashboard.yourdomain.com/#!/login
https://vault.yourdomain.com/ui/vault/init
In conclusion,

After you finish editing and configure your necessary files which mentioned above

Running those commands:

a) `source set-env.sh common_tools.tfvars`

b) `terraform apply -var-file=$DATAFILE`