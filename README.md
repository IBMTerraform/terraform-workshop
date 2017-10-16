
# Welcome to the IBM Cloud University 2017 Schematics Hands-on Lab

## Architecture
This repository will create a whole web shop application as a 3-tier architecture.

**Overall Process**
![regionselector](https://github.com/ICU2017Schematics/ICU2017Lab/blob/master/images/regionselector.png?raw=true)
![regionselector2](images/regionselector.png?raw=true)
You should use Cloud Schematics to create this web shop infrastructure as well as the deployments.
Please see the [step-by-step guide](https://github.com/ICU2017Schematics/ICU2017Lab/blob/master/Instructions.md)

For simplicity and in interest of time, the Kubernetes cluster and the database have been pre-provisioned for this Hands-on. Therefore for those resources there is a `cloudant` and a `cloudant-ref` directory, as well as a `free-cluster`, a `shop-cluster` (which is a paid n-node cluster) and a `cluster-ref` directory. The `*.ref`directories are modules that look for existing resources.

This whole project is based on larger building blocks that are modeled as _Terraform Modules_, like `cloudant`, `lb_vms`. The `modules.tf` file in the root directory accumulates these modules and make up the multi-tier application environment. The `modules.tf` has multiple sections that are partially commented out but left in for educational purposes. If you fork or clone this git repository you can make changes and try variations in your own **IBM Cloud** account.

Code deployments are also done through Terraform, shown in two different variations.

**Backend Layer**

For the ICU Lab, we share the database between participants, therefore the backend is split into 2 modules, one that actually creates the *shopDB* as a singleton, the other just references that backend and pulls the URL from it in order to be able to connect and work with it.

For this reason there's also no reference to the `cloudant` module but only to `cloudant-ref`.

**Fulfillment Layer**

This runs on 2 virtual machines that are accessed through a load balancer. All artifacts are being created in the `lb_vms` module. Provisioning of software is done through the `remote-exec` provisioner.

**Shop Layer**

The front-end, catalog, gateway and cart micro services are running in a single node Kubernetes cluster on IBM Cloud. Provisioning of the micro services is also triggered from the `modules.tf` using a provisioner that runs `kubectl`.
The micro services are load balanced within the cluster and run in 2 instances.
