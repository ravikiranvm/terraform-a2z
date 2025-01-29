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
