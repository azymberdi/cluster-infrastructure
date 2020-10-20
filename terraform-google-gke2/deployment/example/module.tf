module "gke_cluster" {
    source  = "fuchicorp/gke/google"
    cluster_name = "fuchicorp-cluster"
    google_region = "us-central1"
    google_project_id = "fsadykov-project"
    cluster_node_count = "2"
    cluster_version = "1.15"
    google_credentials = "./fuchicorp-service-account.json" # service account 
}