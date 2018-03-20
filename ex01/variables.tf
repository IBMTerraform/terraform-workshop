variable "bluemix-api-key" {
  type        = "string"
  description = "Your Bluemix API Key"
  default     = ""
}

variable "org" {
  type        = "string"
  description = "IBM Cloud Account ORG"
}

variable "space" {
  type        = "string"
  description = "IBM Cloud Account Space"
}

variable "region" {
  type        = "string"
  description = "IBM Cloud Account region"
  default     = "us-south"
}
