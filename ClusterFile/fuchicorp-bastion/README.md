Bastion host deployment
This page contains how to deploy bastion host to FuchiCorp account. If you follow each steps you should be able to deploy successfully.

Before you begin
Make sure you have gihub token
Make sure that dns zone exist on GCP
Also you will need fuchicorp-service-account.json file to be able to deploy
Deployment
Fist you will need to clone the repository

git clone	 https://github.com/fuchicorp/cluster-infrastructure.git
After you have cloned the repo you will need to go to fuchicorp-bastion folder

cd fuchicorp-bastion
in this folder make sure you have fuchicorp-service-account.json file

ls fuchicorp-service-account.json                                                                                                   
cluster-infrastructure/fuchicorp-bastion/fuchicorp-service-account.json
After you have copied fuchicorp service account you will need to generate tfvars.

cat <<EOF > fuchicorp-bastion.tfvars
google_bucket_name = "BUCKET_NAME"
google_project_id = "PROJECT_ID"
google_domain_name = "DOMAIN_NAME"
git_common_token = "Github token from academy ORG"
deployment_environment = "tools"
deployment_name = "bastion"
credentials = "fuchicorp-service-account.json"
EOF 
After you have generated tfvars you will need to set environments variables

source set-env.sh fuchicorp-bastion.tfvars
After you have set environment variables you should be able to deploy to GCP

terraform apply -var-file=$DATAFILE