
##############################################################################
# IBM SSH Key: For connecting to VMs
# use
# ssh -i id_lb root@<ip> to connec to the VMs
##############################################################################
resource "ibm_compute_ssh_key" "ssh_key" {
  label                       = "demo"
  notes                       = "demo"
  # Public key, so this is completely safe
  public_key                  = "${file("${path.module}/id_lb.pub")}"
}

##############################################################################
# Create a local loadbalancer
##############################################################################
resource "ibm_lb" "lb" {
  connections                 = "${var.connections}"
  datacenter                  = "${var.datacenter}"
  ha_enabled                  = "${var.ha_enabled}"
  dedicated                   = "${var.dedicated}"
}

##############################################################################
# Create a service group in the loadbalancer
##############################################################################
resource "ibm_lb_service_group" "lb_service_group" {
  port                        = "${var.service_group_port}"
  routing_method              = "${var.service_group_routing_method}"
  routing_type                = "${var.service_group_routing_type}"
  load_balancer_id            = "${ibm_lb.lb.id}"
  allocation                  = "${var.service_group_allocation}"
}

##############################################################################
# Create a service
# Defines a service for each node; determines the health check,
# load balancer weight, and ip the loadbalancer will send traffic to
##############################################################################
resource "ibm_lb_service" "lb_service" {
  # The number of services to create, based on web node count
  count                       = "${var.node_count}"
  # port to serve traffic on
  port                        = "${var.port}"
  enabled                     = true
  service_group_id            = "${ibm_lb_service_group.lb_service_group.service_group_id}"
  # Even distribution of traffic
  weight                      = 1
  # Uses HTTP to as a healthcheck
  health_check_type           = "HTTP"
  # Where to send traffic to
  ip_address_id               = "${element(ibm_compute_vm_instance.node.*.ip_address_id, count.index)}"
  # For demonstration purposes; creates an explicit dependency
  depends_on                  = ["ibm_compute_vm_instance.node"]
}

##############################################################################
# Create the VMs that will be part of the service group
##############################################################################
resource "ibm_compute_vm_instance" "node" {
  # number of nodes to create, will iterate over this resource
  count                       = "${var.node_count}"
  # demo hostname and domain
  hostname                    = "node-${random_id.short_id.id}"
  domain                      = "mybluemix.net"
  # the operating system to use for the VM
  os_reference_code           = "UBUNTU_LATEST"
  # the datacenter to deploy the VM to
  datacenter                  = "${var.datacenter}"
  private_network_only        = false
  cores                       = 1
  memory                      = 1024
  local_disk                  = true
  ssh_key_ids = [
    "${ibm_compute_ssh_key.ssh_key.id}"
  ]
  # Installs node server on the VM via SSH
  provisioner "remote-exec" {
    connection {
        type                  = "ssh"
        user                  = "root"
        private_key           = "${file("${path.module}/id_lb")}"
    }
    inline                    = [
      "apt-get update -y",
      # Install docker
      "wget -qO- https://get.docker.com/ | sh",
      "apt-get install --yes --allow-downgrades --allow-remove-essential --allow-change-held-packages  docker-compose",
      # Install docker-compose
      "COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP \"[0-9]+\\.[0-9][0-9]+\\.[0-9]+$\" | tail -n 1`",
      "curl -L https://github.com/docker/compose/releases/download/$${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose",
      "chmod +x /usr/local/bin/docker-compose",
      "curl -L https://raw.githubusercontent.com/docker/compose/$${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose",
      # Start the fulfillment apply
      "docker run -d -p 3000:3000 mkubik/ship"
    ]
  }
  # applys tags to the VM
  tags                        = "${var.vm_tags}"
}

resource "random_id" "short_id" {
  byte_length                 = 2
}
