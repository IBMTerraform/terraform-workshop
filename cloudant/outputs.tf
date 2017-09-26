output "shopDbId" {
  value = "${ibm_service_instance.shopDb.id}"
}

output "shopDbSPGuid" {
  value = "${ibm_service_instance.shopDb.service_plan_guid}"
}

output "shopDbURL" {
  value = "${ibm_service_key.serviceKey.credentials.url}"
}

#output "shopDbHost" {
#  value = "${ibm_service_key.serviceKey.credentials.host}"
#}

#output "shopDbUser" {
#  value = "${ibm_service_key.serviceKey.credentials.username}"
#}

#output "shopDbPassword" {
#  value = "${ibm_service_key.serviceKey.credentials.password}"
#}
