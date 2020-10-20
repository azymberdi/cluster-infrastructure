resource "kubernetes_secret" "github_access_token"{
    metadata {
        name = "github-access-token"
        namespace = "tools"
        annotations = { 
              "jenskins.io/credentials-description" = "jenkins library creds" 
              }       
        labels { 
              "jenkins.io/credentials-type" = "usernamePassword"
        }              
    }

    data = {
        "username" = "${var.jenkins["git_token"]}"
        "password" = ""
    }
}