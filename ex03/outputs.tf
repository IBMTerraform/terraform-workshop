output "public_ipv4s" {
  value = ["${ibm_compute_vm_instance.node.*.ipv4_address}"]
}

output "public_ipv6s" {
  value = ["${ibm_compute_vm_instance.node.*.ipv6_address}"]
}

output "loadbalancer_ipv4" {
  value = "${ibm_lb.lb.ip_address}"
}
