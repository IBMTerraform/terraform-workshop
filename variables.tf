variable "ibm_bmx_api_key" {
  type = "string"

  #default = ""
  description = "Your Bluemix API Key (optional)"
}

variable "ibm_sl_username" {
  type = "string"

  #default = ""
  description = "Your IBM Cloud User Name"
}

variable "ibm_sl_api_key" {
  type = "string"

  #default = ""
  description = "Your IBM Cloud API Key"
}

variable "myOrg" {
  type = "string"

  #default = ""
  description = "Your Bluemix ORG"
}

variable "mySpace" {
  type = "string"

  #default = ""
  description = "Your Bluemix Space"
}

variable "myClustername" {
  type = "string"

  default = "myCluster"
  description = "Your k8s cluster name"
}
