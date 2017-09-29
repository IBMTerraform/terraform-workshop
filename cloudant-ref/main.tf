################################################
# This module references the cloudant instance
# on IBM Cloud in the 'cloudant' module subdir for
# https://github.ibm.com/davetropeano/clouduniversity-2017
# It is assumed that the databse already exists.
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
# Load service instance data
################################################
data "ibm_service_instance" "shopDb" {
  name                        = "shopDB"
  space_guid                  = "${data.ibm_space.spaceData.id}"
}

################################################
# Load credentials data
################################################
data "ibm_service_key" "serviceKey" {
  name                        = "mycloudantkey"
  service_instance_name       = "shopDB"
  space_guid                  = "${data.ibm_space.spaceData.id}"
}
