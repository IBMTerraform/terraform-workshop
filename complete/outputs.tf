output "cluster_config" {
  value                       = "${module.shopCluster.cluster_config}"
}

output "cluster_ips" {
  value                       = "${module.shopCluster.cluster_ips}"
}

output "loadbalancer_ip" {
  value                       = "${module.load-balanced-vms.loadbalancer_ipv4}"
}
