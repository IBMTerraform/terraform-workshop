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

variable "cloudantUrl" {
  type = "string"

}

######################################################################
# The datacenter to deploy to
variable datacenter {
  default = "dal06"
}
# The SSH Key to use on the Nginx virtual machines
# Defined in terraform.tfvars
variable public_key {
  description = "Your public SSH key"
}
# This is stored in a file not checked into source control or passed in via command line or stored as a secret in a service wrapping terraform -- should be used with public_key_material (should be of the same key)
variable "private_key_material" {
  description = "The private key material used to connect via SSH; define in terraform.tfvars or if using a service like Terraform Enterprise define it there."
  default = <<-EOF
  ...
  EOF
}
# The number of web nodes to deploy; You can adjust this number to create more
# virtual machines in the IBM Cloud; adjusting this number also updates the
# loadbalancer with the new node
variable node_count {
  default = 2
}
# The target operating system for the web nodes
variable web_operating_system {
  default = "UBUNTU_LATEST"
}
# The port that web and the loadbalancer will serve traffic on
variable port {
  default = "80"
}
# The number of cores each web virtual guest will recieve
variable vm_cores {
  default = 1
}
# The amount of memory each web virtual guest will recieve
variable vm_memory {
  default = 1024
}
# Tags which will be applied to the web VMs
variable vm_tags {
  default = [
    "nginx",
    "webserver",
    "demo"
  ]
}

variable "connections" {
  description = "The number of connections the Load Balancer can support"
  default = 250
}

variable "ha_enabled" {
  description = "(Boolean) Determines if the LB is highly available or not"
  default = false
}

variable "dedicated" {
  description = "(Boolean) Whether the LB is dedicated (single tenant) or not"
  default = false
}

variable "service_group_port" {
  description = "The port that the load balancer will serve traffic on"
  default = 80
}

variable "service_group_routing_method" {
  description = "Routing method for the load balancer, valid options are: CONSISTENT_HASH_IP, INSERT_COOKIE, LEAST_CONNECTIONS, LEAST_CONNECTIONS_INSERT_COOKIE, LEAST_CONNECTIONS_PERSISTENT_IP, PERSISTENT_IP, ROUND_ROBIN, ROUND_ROBIN_INSERT_COOKIE, ROUND_ROBIN_PERSISTENT_IP, SHORTEST_RESPONSE, SHORTEST_RESPONSE_INSERT_COOKIE, SHORTEST_RESPONSE_PERSISTENT_IP. See http://knowledgelayer.softlayer.com/procedure/what-balancing-methods-are-available-load-balancer for more information."
  default = "ROUND_ROBIN"
}

variable "service_group_routing_type" {
  description = "The communication protocol the load balancer will route traffic using. Options are: HTTP, TCP, DNS, FTP, UDP, and HTTPS"
  default = "HTTP"
}

variable "service_group_allocation" {
  description = "The percentage of connections to allocate to the group"
  default = 100
}
