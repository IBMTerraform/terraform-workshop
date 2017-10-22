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

variable "myClustername" {
  type                        = "string"
  default                     = "myCluster"
  description                 = "Your k8s cluster name"
}

variable "region" {
  type                        = "string"
  description                 = "Bluemix region"
  default                     = "eu-gb"
}

variable "workers" {

  default = [{
    name                      = "worker1"
    action                    = "add"
  }]
}
