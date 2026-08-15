## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.00 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.1 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.177.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_net"></a> [net](#module\_net) | github.com/terraform-yc-modules/terraform-yc-vpc.git | 19a9893f25b2536cea3c9c15c180c905ea37bf9c |
| <a name="module_s3"></a> [s3](#module\_s3) | github.com/terraform-yc-modules/terraform-yc-s3.git | 9fc2f832875aefb6051a2aa47b5ecc9a7ea8fde5 |

## Resources

| Name | Type |
|------|------|
| [random_string.bucket_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [terraform_data.get_serial_output](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [time_sleep.wait_120_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [yandex_compute_disk.boot_disk](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk) | resource |
| [yandex_compute_disk.secondary_disk_a](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk) | resource |
| [yandex_compute_disk.secondary_disk_b](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk) | resource |
| [yandex_compute_disk.secondary_disk_d](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk) | resource |
| [yandex_compute_instance.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance) | resource |
| [yandex_compute_snapshot.initial](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_snapshot) | resource |
| [yandex_vpc_address.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_address) | resource |
| [yandex_ydb_database_serverless.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/ydb_database_serverless) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boot_disk_name"></a> [boot\_disk\_name](#input\_boot\_disk\_name) | (Optional) - Name of the boot disk. | `string` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | (Optional) - Name of the bucket. | `string` | `null` | no |
| <a name="input_bucket_sa_name"></a> [bucket\_sa\_name](#input\_bucket\_sa\_name) | (Optional) - Name of the service account for the bucket. | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Optional) - Yandex Cloud Folder ID where resources will be created. | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | (Optional) - Boot disk image id. If not provided, it defaults to Ubuntu 22.04 LTS image id | `string` | `"fd8ba9d5mfvlncknt2kd"` | no |
| <a name="input_instance_resources"></a> [instance\_resources](#input\_instance\_resources) | (Optional) Specifies the resources allocated to an instance.<br/>      - `platform_id`: The type of virtual machine to create.If not provided, it defaults to `standard-v3`.<br/>      - `cores`: The number of CPU cores allocated to the instance.<br/>      - `memory`: The amount of memory (in GiB) allocated to the instance.<br/>      - `disk`: Configuration for the instance disk.<br/>        - `disk_type`: The type of disk for the instance. If not provided, it defaults to `network-ssd`.<br/>        - `disk_size`: The size of the disk (in GiB) allocated to the instance. If not provided, it defaults to 15 GiB. | <pre>object({<br/>    platform_id = optional(string, "standard-v3")<br/>    cores       = number<br/>    memory      = number<br/>    disk = optional(object({<br/>      disk_type = optional(string, "network-hdd")<br/>      disk_size = optional(number, 15)<br/>    }), {})<br/>  })</pre> | n/a | yes |
| <a name="input_linux_vm_name"></a> [linux\_vm\_name](#input\_linux\_vm\_name) | (Optional) - Name of the Linux VM. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) - Name prefix for project. | `string` | `"project"` | no |
| <a name="input_secondary_disks"></a> [secondary\_disks](#input\_secondary\_disks) | (Optional) - Configuration for secondary disks. | <pre>object({<br/>    count = number<br/>    name  = string<br/>    type  = string<br/>    size  = number<br/>  })</pre> | <pre>{<br/>  "count": 2,<br/>  "name": "secondary-disk",<br/>  "size": 10,<br/>  "type": "network-hdd"<br/>}</pre> | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) - A map of AZ to subnets CIDR block ranges. | `map(list(string))` | <pre>{<br/>  "ru-central1-a": [<br/>    "192.168.10.0/24"<br/>  ],<br/>  "ru-central1-b": [<br/>    "192.168.11.0/24"<br/>  ],<br/>  "ru-central1-d": [<br/>    "192.168.12.0/24"<br/>  ]<br/>}</pre> | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | (Optional) - Name of the VPC network. | `string` | `null` | no |
| <a name="input_ydb_serverless_name"></a> [ydb\_serverless\_name](#input\_ydb\_serverless\_name) | (Optional) - Name of the YDB serverless. | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) - Yandex Cloud Zones for provisoned resources. | `set(string)` | <pre>[<br/>  "ru-central1-a"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_boot_disk_ids"></a> [boot\_disk\_ids](#output\_boot\_disk\_ids) | The IDs of the boot disks created for the instances. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the Yandex Object Storage bucket. |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | The IDs of the Yandex Compute instances. |
| <a name="output_instance_public_ip_address"></a> [instance\_public\_ip\_address](#output\_instance\_public\_ip\_address) | The external IP addresses of the instances. |
| <a name="output_serial_port_files"></a> [serial\_port\_files](#output\_serial\_port\_files) | The Serial port's output files. |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | The ID of the Yandex IAM service account. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | The IDs of the VPC subnets used by the Yandex Compute instance. |
| <a name="output_ydb_id"></a> [ydb\_id](#output\_ydb\_id) | The ID of the Yandex Managed Service for YDB instance. |
