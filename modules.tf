##############################################################################
# IBM Kubernetes Cluster
# https://ibm-bluemix.github.io/tf-ibm-docs/v0.4.0/r/container_cluster.html
##############################################################################
# Free K8s cluster on IBM Cloud
# This uses a module to create these resources
#module "freeCluster" {
#  source = "./free-cluster"
#  ibm_bmx_api_key = "${var.ibm_bmx_api_key}"
#  myOrg = "${var.myOrg}"
#  mySpace = "${var.mySpace}"
#  myClustername = "${var.myClustername}"
#}

module "shopCluster" {
  source = "./shop-cluster"
  ibm_bmx_api_key = "${var.ibm_bmx_api_key}"
  ibm_sl_username = "${var.ibm_sl_username}"
  ibm_sl_api_key = "${var.ibm_sl_api_key}"
  myOrg = "${var.myOrg}"
  mySpace = "${var.mySpace}"
  myClustername = "${var.myClustername}"
  cloudantUrl = "${module.shopDBCloudant.shopDbURL}"
}

module "shopDBCloudant" {
  source = "./cloudant-ref"
  ibm_bmx_api_key = "${var.ibm_bmx_api_key}"
  myOrg = "${var.myOrg}"
  mySpace = "${var.mySpace}"
}

output "cluster_config" {
    value = "${module.shopCluster.cluster_config}"
}
