data "ibm_org" "orgData" {
  org = "${var.myOrg}"
}

data "ibm_space" "spaceData" {
  space = "${var.mySpace}"
  org   = "${data.ibm_org.orgData.org}"
}

data "ibm_account" "accountData" {
  org_guid = "${data.ibm_org.orgData.id}"
}

data "ibm_container_cluster_config" "cluster_cfg" {
  org_guid        = "${data.ibm_org.orgData.id}"
  space_guid      = "${data.ibm_space.spaceData.id}"
  account_guid    = "${data.ibm_account.accountData.id}"
  cluster_name_id = "${ibm_container_cluster.test_cluster.id}"
  config_dir      = "/tmp"
  depends_on      = ["ibm_container_cluster.test_cluster"]
}

resource "ibm_container_cluster" "test_cluster" {
  name         = "${var.myClustername}"
  datacenter   = "dal10"
  machine_type = "u1c.2x4"
  isolation    = "public"
  public_vlan_id = "1520295"
  private_vlan_id = "1520297"

  workers = [{
    name = "worker1"
    action = "add"
  },
  {
    name = "worker2"
    action = "add"
  }]


  org_guid     = "${data.ibm_org.orgData.id}"
  space_guid   = "${data.ibm_space.spaceData.id}"
  account_guid = "${data.ibm_account.accountData.id}"
}
