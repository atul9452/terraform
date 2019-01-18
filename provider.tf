######################################################################
###                                                                ###
### This block is for taking the data from variable value          ### 
###                                                                ###
###                                                                ###
######################################################################

provider "openstack" {
  user_name   = "${var.user_name}"
  tenant_name = "${var.tenant_name}"
  password    = "${var.password}"
  auth_url    = "${var.auth_url}"
  insecure    =   true
  region      = "${var.region}"
}


