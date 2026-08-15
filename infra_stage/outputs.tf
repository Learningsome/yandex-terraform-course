output "subnet_ids" {
  description = "The IDs of the VPC subnets used by the Yandex Compute instance."
  value = {
    for subnet in yandex_vpc_subnet.private :
    subnet.name => subnet.id
  }
}

output "boot_disk_ids" {
  description = "The IDs of the boot disks created for the instances."
  value = {
    for disk in yandex_compute_disk.boot_disk :
    disk.name => disk.id
  }
}

output "instance_ids" {
  description = "The IDs of the Yandex Compute instances."
  value = {
    for instance in yandex_compute_instance.this :
    instance.name => instance.id
  }
}

output "ydb_id" {
  description = "The ID of the Yandex Managed Service for YDB instance."
  value       = yandex_ydb_database_serverless.this.id
}

output "service_account_id" {
  description = "The ID of the Yandex IAM service account."
  value       = yandex_iam_service_account.bucket.id
}

output "bucket_name" {
  description = "The name of the Yandex Object Storage bucket."
  value       = yandex_storage_bucket.this.bucket
}

output "access_key" {
  description = "The static access key of the s3 bucket service account."
  value       = yandex_iam_service_account_static_access_key.this.access_key
  sensitive   = true
}

output "secret_key" {
  description = "The static secret key of the s3 bucket service account."
  value       = yandex_iam_service_account_static_access_key.this.secret_key
  sensitive   = true
}

output "instance_public_ip_address" {
  description = "The external IP addresses of the instances."
  value = {
    for address in yandex_vpc_address.this :
    address.name => address.external_ipv4_address[0].address
  }
}

output "all_subnets" {
  description = "The list of all subnets."
  value       = local.all_subnets
}
