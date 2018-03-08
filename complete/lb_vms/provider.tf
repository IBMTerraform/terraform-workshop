# Configure the IBM Cloud Provider
provider "ibm" {
  bluemix_api_key             = "${var.ibm_bmx_api_key}"
  softlayer_username          = "${var.ibm_sl_username}"
  softlayer_api_key           = "${var.ibm_sl_api_key}"
}
