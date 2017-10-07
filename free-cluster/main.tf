################################################
# This module creates a free 1-node kubernetes cluster
# that will be the home of the web shop.
################################################

################################################
# Load org data
################################################
data "ibm_org" "orgData" {
  org                         = "${var.myOrg}"
}

################################################
# Load space data
################################################
data "ibm_space" "spaceData" {
  space                       = "${var.mySpace}"
  org                         = "${data.ibm_org.orgData.org}"
}

################################################
# Load account data
################################################
data "ibm_account" "accountData" {
  org_guid                    = "${data.ibm_org.orgData.id}"
}

################################################
# Load cluster configuration to access it with
# the provisioner
################################################
data "ibm_container_cluster_config" "cluster_cfg" {
  org_guid                    = "${data.ibm_org.orgData.id}"
  space_guid                  = "${data.ibm_space.spaceData.id}"
  account_guid                = "${data.ibm_account.accountData.id}"
  cluster_name_id             = "${ibm_container_cluster.shop_cluster.id}"
  config_dir                  = "/tmp"
  depends_on                  = ["ibm_container_cluster.shop_cluster"]
}

################################################
# Create the cluster
################################################
resource "ibm_container_cluster" "shop_cluster" {
  name                        = "${var.myClustername}"
  datacenter                  = "dal10"
  machine_type                = "free"
  isolation                   = "public"

  workers = [{
    name                      = "worker1"

    action                    = "add"
  }]

  org_guid                    = "${data.ibm_org.orgData.id}"
  space_guid                  = "${data.ibm_space.spaceData.id}"
  account_guid                = "${data.ibm_account.accountData.id}"
}
