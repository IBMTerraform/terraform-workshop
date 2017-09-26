
# Welcome to the IBM Cloud University 2017 Schematics Hands-on Lab

## Architecture
This repository will create a whole web shop application as a 3-tier architecture.

**Overall Process**

You should use Cloud Schematics to create this web shop infrastructure as well as the deployments.

Terraform will be run in the root directory of this repository and will initially check the `variables.tf` and `modules.tf` files. From the `modules.tf` there are references to other modules.

This is also the spot from where the deployments are triggered.

**Backend Layer**

For the ICU Lab, we share the database between participants, therefore the backend is split into 2 modules, one that actually creates the *shopDB* as a singleton, the other just references that backend and pulls the URL from it in order to be able to connect and work with it.

For this reason there's also no reference to the `cloudant` module but only to `cloudant-ref`.

**Fulfillment Layer**

This runs on 2 virtual machines that are accessed through a load balancer. All artefacts are being created in the `lb_vms` module.

**Shop Layer**

The front-end, catalog and cart micro services are running in a 2 node Kubernetes cluster on IBM Cloud. Provisioning of the micro services is also triggered from the `modules.tf` using a provisioner that runs `kubectl`.
The micro services are load balanced within the cluster and run in 2 instances.
