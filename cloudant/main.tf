data "ibm_org" "orgData" {
  org = "${var.myOrg}"
}

data "ibm_space" "spaceData" {
  space = "${var.mySpace}"
  org   = "${data.ibm_org.orgData.org}"
}

resource "ibm_service_instance" "shopDb" {
  name       = "shopDB"
  space_guid = "${data.ibm_space.spaceData.id}"
  service    = "cloudantNoSQLDB"
  plan       = "Lite"
  tags       = ["cluster-service", "cluster-bind"]
}

resource "ibm_service_key" "serviceKey" {
  name                  = "mycloudantkey"
  service_instance_guid = "${ibm_service_instance.shopDb.id}"
}
