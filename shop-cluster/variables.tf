variable "ibm_bmx_api_key" {
  type                        = "string"
  description                 = "Your Bluemix API Key (optional)"
}

variable "ibm_sl_username" {
  type                        = "string"
  description                 = "Your IBM Cloud User Name"
}

variable "ibm_sl_api_key" {
  type                        = "string"
  description                 = "Your IBM Cloud API Key"
}

variable "region" {
  type                        = "string"
  description                 = "Bluemix region"
  default                     = "eu-gb"
}

variable "myOrg" {
  type                        = "string"
  description                 = "Your Bluemix ORG"
}

variable "mySpace" {
  type                        = "string"
  description                 = "Your Bluemix Space"
}

variable "myClustername" {
  type                        = "string"
  default                     = "myCluster"
  description                 = "Your k8s cluster name"
}

variable "public_vlan_id" {
  type                        = "string"
  description                 = "Your public VLAN ID. check with 'bx cs vlans <datacenter>'"
}

variable "private_vlan_id" {
  type                        = "string"
  description                 = "Your public VLAN ID. check with 'bx cs vlans <datacenter>'"
}

variable "datacenter" {
  type                        = "string"
  default                     = "dal10"
  description                 = "Your datacenter. check with 'bx cs locations'"
}
