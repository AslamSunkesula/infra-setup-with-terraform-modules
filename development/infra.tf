module "dev_vpc_1" {
  source              = "../modules/network"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  environment         = var.environment
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  azs                 = var.azs
  aws_region          = var.aws_region
}

module "dev_natgw_1" {
  source           = "../modules/nat"
  vpc_name         = module.dev_vpc_1.vpc_name
  public_subnet_id = module.dev_vpc_1.public_subnets_id_1
}

