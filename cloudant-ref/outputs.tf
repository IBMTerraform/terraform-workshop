output "shopDbId" {
  value = "${data.ibm_service_instance.shopDb.id}"
}

output "shopDbSPGuid" {
  value = "${data.ibm_service_instance.shopDb.service_plan_guid}"
}

output "shopDbURL" {
  value = "${data.ibm_service_key.serviceKey.credentials.url}"
}

output "shopDbHost" {
  value = "${data.ibm_service_key.serviceKey.credentials.host}"
}

output "shopDbUser" {
  value = "${data.ibm_service_key.serviceKey.credentials.username}"
}

output "shopDbPassword" {
  value = "${data.ibm_service_key.serviceKey.credentials.password}"
}
