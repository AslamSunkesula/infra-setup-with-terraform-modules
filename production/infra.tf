module "prod_vpc_1" {
  source              = "../modules/network"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  environment         = var.environment
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  azs                 = var.azs


}
module "prod_sg_1" {
  source        = "../modules/sg"
  vpc_name      = module.prod_vpc_1.vpc_name
  vpc_id        = module.prod_vpc_1.vpc_id
  environment   = module.prod_vpc_1.environment
  service_ports = ["80", "443", "445", "8080", "22", "3389", "1433", "3306"]
}




module "prod_natgw_1" {
  source           = "../modules/nat"
  vpc_name         = module.prod_vpc_1.vpc_name
  public_subnet_id = module.prod_vpc_1.public_subnets_id_1

}











# vpc_cidr           = "10.90.0.0/16"
# vpc_name           = "dev_vpc_1"
# environment        = "Production"
# public_subnet_cidr = ["10.90.1.0/24", "10.90.2.0/24", "10.90.3.0/24"]
# private_subnet_cidr = ["10.90.10.0/24", "10.90.20.0/24", "10.90.30.0/24"]
# azs                = ["us-east-1a", "us-east-1b", "us-east-1c"] 


