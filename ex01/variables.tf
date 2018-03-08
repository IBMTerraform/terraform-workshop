variable "bluemix-api-key" {
  type                        = "string"
  description                 = "Your Bluemix API Key"
  default                     = "KnIBFHcSTS-FKJwuREJam5ebVGf2tspI2TeU57w3z0ZJ"
}

variable "org" {
  type                        = "string"
  description                 = "IBM Cloud Account ORG"
}

variable "space" {
  type                        = "string"
  description                 = "IBM Cloud Account Space"
}

variable "region" {
  type                        = "string"
  description                 = "IBM Cloud Account region"
  default                     = "us-south"
}
