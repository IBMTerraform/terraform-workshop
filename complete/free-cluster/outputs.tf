output "cluster_config" {
  value = "${data.ibm_container_cluster_config.cluster_cfg.config_file_path}"
}

output "cluster_ips" {
  value = "${data.ibm_container_cluster_worker.shop_cluster_workers.public_ip}"
}
