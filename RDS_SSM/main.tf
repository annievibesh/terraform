provider "aws" {
 region = "eu-central-1"
 }
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = data.aws_ssm_parameter.rds_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately     =true
}
resource "random_password" "main"{
 length = 20
 special = true
 override_special = "#!_"
 }
 
resource "aws_ssm_parameter" "rds_password"{
 name ="/prod1/prod-mysql-rds/password"
 description = "password for rds"
 type = "SecureString"
 value= random_password.main.result
 }

data "aws_ssm_parameter" "rds_password" {
 name ="/prod1/prod-mysql-rds/password"
 depends_on = [aws_ssm_parameter.rds_password]
 }
 output "rds_address" {
 value=aws_db_instance.default.address
 }
 output "rds_port"{
 value=aws_db_instance.default.port
 }
 output "rds_username" {
 value=aws_db_instance.default.username
}
 output "rds_password"{
 value=aws_db_instance.default.password
 sensitive = true
 }

