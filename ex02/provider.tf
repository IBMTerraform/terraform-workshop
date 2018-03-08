################################################
# Configure the IBM Cloud Provider
################################################
provider "ibm" {
  bluemix_api_key             = "${var.bluemix-api-key}"
  region                      = "us-south"
}
