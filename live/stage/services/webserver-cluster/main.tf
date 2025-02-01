provider "aws" {
    region = "us-east-1"
}

module "webserver-cluster" {
    source = "../../../../modules/services/webserver-cluster"
    cluster_name = "webservers-stage"
    db_remote_state_bucket = "terraform-stat-25v001"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    min_size = 2
    max_size = 2
}



