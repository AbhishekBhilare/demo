module "ec2" {
  source        = "../modules"
  instance-name = var.Dev-instance-name
  instance_ami  = var.Dev-instance-ami
  instance_type = var.Dev-instance-type
}

