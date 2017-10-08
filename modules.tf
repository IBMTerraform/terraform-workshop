##############################################################################
# IBM Kubernetes Cluster
# https://ibm-bluemix.github.io/tf-ibm-docs/v0.4.0/r/container_cluster.html
##############################################################################
##############################################################################
# Call the module to create a free Kubernetes cluster - use either or
##############################################################################
// module "shopCluster" {
//   source                      = "./free-cluster"
//   ibm_bmx_api_key             = "${var.ibm_bmx_api_key}"
//   myOrg                       = "${var.myOrg}"
//   mySpace                     = "${var.mySpace}"
//   myClustername               = "${var.myClustername}"
// }

##############################################################################
# Call the module to create a paid 2-node Kubernetes cluster - use either or
##############################################################################
// module "shopCluster" {
//   source                      = "./shop-cluster"
//   ibm_bmx_api_key             = "${var.ibm_bmx_api_key}"
//   ibm_sl_username             = "${var.ibm_sl_username}"
//   ibm_sl_api_key              = "${var.ibm_sl_api_key}"
//   myOrg                       = "${var.myOrg}"
//   mySpace                     = "${var.mySpace}"
//   myClustername               = "${var.myClustername}"
//   private_vlan_id             = "${var.private_vlan_id}"
//   public_vlan_id              = "${var.public_vlan_id}"
// }

##############################################################################
# Just referece a pre-provisioned cluster for now in interest of time
##############################################################################
module "shopCluster" {
  source                      = "./cluster-ref"
  ibm_bmx_api_key             = "${var.ibm_bmx_api_key}"
  myOrg                       = "${var.myOrg}"
  mySpace                     = "${var.mySpace}"
  myClustername               = "${var.myClustername}"
}

##############################################################################
# Create the load-balanced VMs to host the
##############################################################################
module "load-balanced-vms" {
  source                      = "./lb_vms"
  ibm_bmx_api_key             = "${var.ibm_bmx_api_key}"
  ibm_sl_username             = "${var.ibm_sl_username}"
  ibm_sl_api_key              = "${var.ibm_sl_api_key}"
  myOrg                       = "${var.myOrg}"
  mySpace                     = "${var.mySpace}"
  cloudanturl                 = "https://${module.shopDBCloudant.shopDbHost}"
  cloudantpass                = "${module.shopDBCloudant.shopDbPassword}"
  cloudantuser                = "${module.shopDBCloudant.shopDbUser}"
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
# Deploy the shop application on the free K8s cluster
##############################################################################
resource "null_resource" "kube-deploy" {
  provisioner "local-exec" {
    command                   = <<EOT
CLOUDANT_USER="${module.shopDBCloudant.shopDbUser}" \
CLOUDANT_PASS="${module.shopDBCloudant.shopDbPassword}" \
CLOUDANT_URL="https://${module.shopDBCloudant.shopDbHost}" \
SHIP_ENDPOINT="http://${module.load-balanced-vms.loadbalancer_ipv4}"
KUBECONFIG="${module.shopCluster.cluster_config}" \
 ./deployments/shop/kube-deploy-free.sh
EOT
  }
}

output "cluster_config" {
    value                     = "${module.shopCluster.cluster_config}"
}
