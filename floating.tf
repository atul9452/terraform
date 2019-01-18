##################################################################
###                                                            ###
### It is trying to assign a floating ip to vm or server from  ### 
### Non-Prod Pool.                                             ###
###                                                            ###
##################################################################

resource "openstack_networking_floatingip_v2" "fip_1"  {
  pool = "Non-Prod"
}

resource "openstack_networking_floatingip_v2" "fip_2"  {
  pool = "Non-Prod"
}

##################################################################
###                                                            ###
### These block is attaching the flaoting ip to correspondings ### 
###              VM    or     Server                           ###
###                                                            ###
##################################################################
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.basic.id}"
}

resource "openstack_compute_floatingip_associate_v2" "fip_2" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_2.address}"
  instance_id = "${openstack_compute_instance_v2.basic1.id}"
}

