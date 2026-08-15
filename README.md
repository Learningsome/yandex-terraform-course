# yandex-terraform-course

Курс: <https://practicum.yandex.ru/profile/yc-devops-terraform/>

## Для работы необходимо

```bash
# Для работы с Yandex Cloud
export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id id_of_terraform_sa)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

# Для работы с AWS S3
export AWS_ACCESS_KEY_ID="mock_access_key"
export AWS_SECRET_ACCESS_KEY="mock_secret_key"
```

## Если установлен devenv

Все нужные переменные и утилиты будут установлены автоматически

```bash
# Заходим в development shell
devenv shell
```
