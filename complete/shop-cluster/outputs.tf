################################################
# Provide the cluster configuration
################################################
output "cluster_config" {
  value = "${data.ibm_container_cluster_config.cluster_cfg.config_file_path}"
}
