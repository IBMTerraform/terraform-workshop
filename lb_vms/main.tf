
##############################################################################
# IBM SSH Key: For connecting to VMs
# http://ibmcloudterraformdocs.chriskelner.com/docs/providers/ibmcloud/r/infra_ssh_key.html
##############################################################################
resource "ibm_compute_ssh_key" "ssh_key" {
  label = "demo"
  notes = "demo"
  # Public key, so this is completely safe
  public_key = "${var.public_key}"
}

resource "ibm_lb" "lb" {
  connections = "${var.connections}"
  datacenter = "${var.datacenter}"
  ha_enabled = "${var.ha_enabled}"
  dedicated = "${var.dedicated}"
}

resource "ibm_lb_service_group" "lb_service_group" {
  port = "${var.service_group_port}"
  routing_method = "${var.service_group_routing_method}"
  routing_type = "${var.service_group_routing_type}"
  load_balancer_id = "${ibm_lb.lb.id}"
  allocation = "${var.service_group_allocation}"
}

# Defines a service for each node; determines the health check, load balancer weight, and ip the loadbalancer will send traffic to
resource "ibm_lb_service" "lb_service" {
  # The number of services to create, based on web node count
  count = "${var.node_count}"
  # port to serve traffic on
  port = "${var.port}"
  enabled = true
  service_group_id = "${ibm_lb_service_group.lb_service_group.service_group_id}"
  # Even distribution of traffic
  weight = 1
  # Uses HTTP to as a healthcheck
  health_check_type = "HTTP"
  # Where to send traffic to
  ip_address_id = "${element(ibm_compute_vm_instance.fulfillmentVM.*.ip_address_id, count.index)}"
  # For demonstration purposes; creates an explicit dependency
  depends_on = ["ibm_compute_vm_instance.fulfillmentVM"]
}

resource "ibm_compute_vm_instance" "fulfillmentVM" {
  # number of nodes to create, will iterate over this resource
  count                = "${var.node_count}"
  # demo hostname and domain
  hostname             = "fulfillment-node-${count.index+1}"
  domain               = "mybluemix.net"
  # the operating system to use for the VM
  os_reference_code    = "UBUNTU_LATEST"
  # the datacenter to deploy the VM to
  datacenter           = "${var.datacenter}"
  private_network_only = false
  cores                = 1
  memory               = 1024
  local_disk           = true
  ssh_key_ids = [
    "${ibm_compute_ssh_key.ssh_key.id}"
  ]
  # Installs fulfillment server on the VM via SSH
  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "root"
        private_key = "${var.private_key_material}"
    }
    inline = [
      "apt-get update -y",
      # Install docker
      "apt-get install --yes --force-yes docker.io",
      # Overwrite default nginx welcome page w/ mac address of VM NIC
      "echo \"<h1>I am $(cat /sys/class/net/eth0/address)</h1>\" > \"/var/www/html/index.nginx-debian.html\""
    ]
  }
  provisioner "file" {
    connection {
        type = "ssh"
        user = "root"
        # This is stored in a file not checked into source control
        private_key = "${var.private_key_material}"
    }
    source = "hello.conf"
    destination = "/etc/nginx/conf.d/hello.conf"
  }
  # applys tags to the VM
  tags = "${var.vm_tags}"
}
