variable "server_port" {
    description = "the port the server will use"
    type = number 
    default = 8080
}

variable "cluster_name" {
    description = "the name to use for all the cluster resources"
    type = string
}

variable "db_remote_state_bucket" {
    description = "The name of the S3 bucket for database's remote state"
    type = string
}

variable "db_remote_state_key" {
    description = "The path for the database's remote state file in S3"
    type = string
}

variable "instance_type" {
    description = "the type of ec2 instances to run in the cluster"
    type = string
}

variable "min_size" {
    description = "the minimum number of instances to run in the ASG"
    type = number
}

variable "max_size" {
    description = "the maximum number of instances to run in the ASG"
    type = number
  
}