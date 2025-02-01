variable "db_username" {
    description = "the username of the db"
    type = string
    sensitive = true
}

variable "db_password" {
    description = "the password of the db"
    type = string
    sensitive = true
}

variable "db_name" {
    description = "the name of the db"
    type = string
    default = "mydbstage"
}