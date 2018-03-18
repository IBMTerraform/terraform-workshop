# Configure the IBM Cloud Provider
provider "ibm" {
  softlayer_username          = "${var.ibm_sl_username}"
  softlayer_api_key           = "${var.ibm_sl_api_key}"
}
