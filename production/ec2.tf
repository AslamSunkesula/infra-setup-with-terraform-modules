module "prod_ec2_1" {
  source = "../modules/compute"

  amis = {
    us-east-1 = "ami-0e2c8caa4b6378d8c"
    us-east-2 = "ami-036841078a4b68e14"

  }
  environment         = module.prod_vpc_1.environment
  aws_region          = var.aws_region
  instance_type       = "t2.micro"
  key_name            = "bastian"
  public_subnet_cidr  = module.prod_vpc_1.public_subnet_cidr
  private_subnet_cidr = module.prod_vpc_1.private_subnet_cidr
  sg_id               = module.prod_sg_1.sg_id
  vpc_name            = module.prod_vpc_1.vpc_name
  elb_listener        = module.prod_elb_1.elb_listner
  elb_listener_public = module.prod_elb_1_public.elb_listner
}



module "prod_elb_1" {
  source          = "../modules/elb"
  lbname          = "prod-nlb"
  subnets         = module.prod_vpc_1.public_subnet_cidr
  environment     = module.prod_vpc_1.environment
  lgname          = "prod-nlb-lg"
  vpc_id          = module.prod_vpc_1.vpc_id
  private_servers = module.prod_ec2_1.private_servers
}


module "prod_elb_1_public" {
  source          = "../modules/elb"
  lbname          = "prod-nlb-public"
  subnets         = module.prod_vpc_1.public_subnet_cidr
  environment     = module.prod_vpc_1.environment
  lgname          = "prod-nlb-lg-public"
  vpc_id          = module.prod_vpc_1.vpc_id
  private_servers = module.prod_ec2_1 .public_servers
}


module "prod_iam_1" {
  source              = "../modules/iam"
  environment         = module.prod_vpc_1.environment
  rolename            = "AslamRole"
  instanceprofilename = "AslamPofile"
}