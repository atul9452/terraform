######################################################################
###                                                                ###
### These two blocks are for showing the output on command prompt  ### 
###                                                                ###
###                                                                ###
######################################################################


output "floating_dbServer" {
  value = "${openstack_networking_floatingip_v2.fip_1.address}"
}

output "floating_webServer" {
  value = "${openstack_networking_floatingip_v2.fip_2.address}"
}