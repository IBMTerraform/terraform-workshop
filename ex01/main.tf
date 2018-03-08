data "ibm_org" "orgData" {
  org                         = "${var.org}"
}

data "ibm_space" "spaceData" {
  space                       = "${var.space}"
  org                         = "${data.ibm_org.orgData.org}"
}

resource "ibm_service_instance" "shopDb" {
  name                        = "shopDB"
  space_guid                  = "${data.ibm_space.spaceData.id}"
  service                     = "cloudantNoSQLDB"
  plan                        = "Lite"
  tags                        = ["shopDB"]
}

resource "ibm_service_key" "serviceKey" {
  name                        = "mycloudantkey"
  service_instance_guid       = "${ibm_service_instance.shopDb.id}"
}
