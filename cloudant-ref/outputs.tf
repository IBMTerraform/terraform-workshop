output "shopDbId" {
  value = "${data.ibm_service_instance.shopDb.id}"
}

output "shopDbSPGuid" {
  value = "${data.ibm_service_instance.shopDb.service_plan_guid}"
}

output "shopDbURL" {
  value = "${data.ibm_service_key.serviceKey.credentials.url}"
}
