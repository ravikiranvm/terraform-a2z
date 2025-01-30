resource "aws_db_instance" "web-db" {
    identifier_prefix = "web-db"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t3.micro"
    skip_final_snapshot = true
    db_name = "webdatabase"
  
    username = var.db_username
    password = var.db_password
}

# Backend for this db
terraform {
    backend "s3" {
        bucket = "terraform-stat-25v001"
        key    = "stage/data-stores/mysql/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}