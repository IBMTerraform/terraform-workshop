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

##############################################################################
# Call the module to create the Kubernetes cluster
##############################################################################
module "shopCluster" {
  source                      = "./shop-cluster"
  ibm_bmx_api_key             = "${var.ibm_bmx_api_key}"
  ibm_sl_username             = "${var.ibm_sl_username}"
  ibm_sl_api_key              = "${var.ibm_sl_api_key}"
  myOrg                       = "${var.myOrg}"
  mySpace                     = "${var.mySpace}"
  myClustername               = "${var.myClustername}"
  private_vlan_id             = "${var.private_vlan_id}"
  public_vlan_id              = "${var.public_vlan_id}"
}

##############################################################################
# Call the module to reference the already existing database
##############################################################################
module "shopDBCloudant" {
  source                      = "./cloudant-ref"
  ibm_bmx_api_key             = "${var.ibm_bmx_api_key}"
  myOrg                       = "${var.myOrg}"
  mySpace                     = "${var.mySpace}"
}

##############################################################################
# Deploy the shop application on the K8s cluster
##############################################################################
resource "null_resource" "kube-deploy" {
  provisioner "local-exec" {
    command                   = <<EOT
CLOUDANT_USER=${module.shopDBCloudant.shopDbUser} \
CLOUDANT_PASS="${module.shopDBCloudant.shopDbPassword}" \
CLOUDANT_URL="https://${module.shopDBCloudant.shopDbHost}" \
KUBECONFIG="${module.shopCluster.cluster_config}" \
 ./deployments/shop/kube-deploy.sh
EOT
  }
}

output "cluster_config" {
    value                     = "${module.shopCluster.cluster_config}"
}
