## 29 Jan 2024

1. ASG template with image id and instance type
2. Setup ASG
3. ALB
4. Listener for ALB
5. Listener Rule for ALB
6. Target Group for ALB
7. SG for ALB
8. SG for EC2 instances
9. Variable for server port
10. Query VPC data
11. Query Subnets of the VPC by referencing the VPC id
12. Output ALB's DNS name


## Notes to remember:

- An AMI may not be supported in all AZs in a region
- Check heredoc syntax to write strings withint terraform config. (Ex. User Data)
- Check dependancy graph using 
```
terraform graph 
```
- Check terraform outputs using
```
terraform output 
```
- It is better to use ports above 1024 for web servers and use 80 for load balancers for security reasons.

## 30 Jan 2024

1. Terraform state isolation by workspace
2. Terraform state isolation by file structure
3. Inputs can be referenced to a remote state using 
```
terraform_remote_state data block
```
4. Terraform locks state file during the progess of terraform apply command and will be relased once completed.
5. Prevent destroy attribute for S3 bucket to avoid accidental deletion. 
6. State file storage in S3
7. To move the state to local, first delete the backend resource, then apply it. 
8. Variables cannot be used in terraform backend block.
9. Workspaces are useful to test small infrastructure size for quick testing. It will be in the same account and same config will be replicated for testing.
10. To create a new workspace
```
terraform workspace new workspace_name
```
11. To change the workspace
```
terraform workspace select workspace_name
```
12. To list workspaces
```
terraform workspace list
```
13. Each workspace created infra with a separate state file.
14. One way to input env variable is by using
```
export TF_VAR_variable_name="value"
```
15. templatefile is a built-in functions which renders a file from its path and then returns a string. This can be used for inputting ec2 user-data.
