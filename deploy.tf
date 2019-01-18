####################################################################
###                                                              ###
### First Block is creating the database server(vm) with userdata###
###                                                              ###
###################################################################
resource "openstack_compute_instance_v2" "basic" {
  name         = "test_sql_a"
  image_name   = "${var.image}"
  flavor_name  = "${var.flavor}"
  key_pair        = "atul_key"
  security_groups = ["terraform_test"]
  

 network {
  name= "atul_tf"
 }

 user_data = "${file("database.sh")}"
 
}

####################################################################
###                                                              ###
### This block is trying to assign the floating ip of database   ###
### to user script which is trying to deploy a php app           ###
###                                                              ###
###################################################################


data "template_file" "webInstall" {
  template = "${file("webInstall.sh")}"

  vars {
    floatip = "${openstack_networking_floatingip_v2.fip_1.address}"
  }
}


####################################################################
###                                                              ###
### This block is trying to create webServer with userdata       ###       
###                                                              ###
####################################################################



resource "openstack_compute_instance_v2" "basic1" {
  name         = "web"
  image_name   = "${var.image}"
  flavor_name  = "${var.flavor}"
  key_pair        = "atul_key"
  security_groups = ["terraform_test"]
  

 network {
  name= "atul_tf"
 }


 user_data = "${data.template_file.webInstall.rendered}"
 
}
