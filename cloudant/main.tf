################################################
# This module creates a new cloudant instance
# on IBM Cloud with new credentials and it loads
# database content for the sample application
# found at
# https://github.ibm.com/davetropeano/clouduniversity-2017
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
# Create cloudant instance
################################################
resource "ibm_service_instance" "shopDb" {
  name                        = "shopDB"
  space_guid                  = "${data.ibm_space.spaceData.id}"
  service                     = "cloudantNoSQLDB"
  plan                        = "Lite"
  tags                        = ["shopDB"]
}

################################################
# Generate access info
################################################
resource "ibm_service_key" "serviceKey" {
  name                        = "mycloudantkey"
  service_instance_guid       = "${ibm_service_instance.shopDb.id}"
  ################################################
  # Load database
  ################################################
  provisioner "local-exec" {
    command                    = "${var.subdir}/loadDb.sh ${ibm_service_key.serviceKey.credentials.url}"
  }
}
