data "ibm_org" "orgData" {
  org = "${var.myOrg}"
}

data "ibm_space" "spaceData" {
  space = "${var.mySpace}"
  org   = "${data.ibm_org.orgData.org}"
}

data "ibm_service_instance" "shopDb" {
  name = "shopDB"
}

data "ibm_service_key" "serviceKey" {
  name                  = "mycloudantkey"
  service_instance_name = "shopDB"
}
