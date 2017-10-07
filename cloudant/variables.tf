################################################
# Required variables
################################################
variable "ibm_bmx_api_key" {
  type                        = "string"
  description                 = "Your Bluemix API Key (optional)"
}

variable "myOrg" {
  type                        = "string"
  description                 = "Your Bluemix ORG"
}

variable "mySpace" {
  type                        = "string"
  description                 = "Your Bluemix Space"
}

variable "region" {
  type                        = "string"
  description                 = "Bluemix region"
  default                     = "eu-gb"
}
