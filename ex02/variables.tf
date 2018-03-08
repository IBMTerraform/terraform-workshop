variable "bluemix-api-key" {
  type                        = "string"
  description                 = "Your Bluemix API Key"
}


variable "org" {
  type                        = "string"
  description                 = "Your Bluemix ORG"
}

variable "space" {
  type                        = "string"
  description                 = "Your Bluemix Space"
}

variable "myClusterName" {
  type                        = "string"
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
  description                 = "Your datacenter. check with 'bx cs locations'"
}
