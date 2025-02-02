provider "aws" {
    region = "us-east-1"
}

module "webserver-cluster" {
    source = "github.com/ravikiranvm/terraform-a2z-module//services/webserver-cluster?ref=v0.0.1"
    cluster_name = "webservers-stage"
    db_remote_state_bucket = "terraform-stat-25v001"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    min_size = 2
    max_size = 2
}

