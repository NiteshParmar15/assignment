module "vpc" {
  source = "./vpc"
  vpc_name = var.vpc_name
  security_group = var.security_group

}

module "ec2" {
  source = "./ec2"
  security_group_id= module.vpc.security_group_id
  private_subnet_id= module.vpc.private_subnet_id
  instance_type = var.instance_type
  associate_public_ip = var.associate_public_ip
  depends_on = [
    module.vpc
  ]
}

module "nlb" {
  source = "./loadbalancer"
  public_subnet_id = module.vpc.public_subnet_id
  vpc_id = module.vpc.vpc_id
  aws_instance_id= module.ec2.aws_instance_id
  depends_on = [
    module.ec2
  ]
}