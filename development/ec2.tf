module "dev_ec2_1" {
  source      = "../modules/compute"
  environment = module.dev_vpc_1.environment
  amis = {
    us-east-1 = "ami-0e2c8caa4b6378d8c"
    us-east-2 = "ami-036841078a4b68e14"

  }
  instance_type       = "t2.micro"
  key_name            = "bastian"
  sg_id               = module.dev_sg_1.sg_id
  aws_region          = var.aws_region
  public_subnet_cidr  = module.dev_vpc_1.public_subnet_cidr
  private_subnet_cidr = module.dev_vpc_1.private_subnet_cidr
  vpc_name            = module.dev_vpc_1.vpc_name
  elb_listener        = module.dev_elb_1.elb_listner
  elb_listener_public = module.dev_elb_1_public.elb_listner

}

module "dev_elb_1" {
  source          = "../modules/elb"
  lbname          = "dev-nlb"
  subnets         = module.dev_vpc_1.public_subnet_cidr
  environment     = module.dev_vpc_1.environment
  lgname          = "dev-nlb-lg"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_ec2_1.private_servers
}


module "dev_elb_1_public" {
  source          = "../modules/elb"
  lbname          = "dev-nlb-public"
  subnets         = module.dev_vpc_1.public_subnet_cidr
  environment     = module.dev_vpc_1.environment
  lgname          = "dev-nlb-lg-public"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_ec2_1.public_servers
}


module "dev_iam_1" {
  source              = "../modules/iam"
  environment         = module.dev_vpc_1.environment
  rolename            = "AslamRole"
  instanceprofilename = "AslamPofile"
}