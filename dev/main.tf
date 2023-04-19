module "ec2" {
  source        = "../modules"
  instance-name = var.Dev-instance-name
  instance_ami  = var.Dev-instance-ami
  instance_type = var.Dev-instance-type
  security_groups_name = "ABHISHEK"
  from_port = var.from_port
  to_port = var.to_port
  key-name = var.key_name
  no-of-instance = var.no-of-instance
  
}
