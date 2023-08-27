# tuturu0_infra
tuturu0 Infra repository


# ДЗ №5

- Установка packer с зеркала yandex
- Настрокйка конфигурационного файла packer
- Вынесение переменных в отдельный файл и добавление новых параметров
- Написание конфига и скрипта для создания baked-образа с демоном реддита
- Написание скрипта для содания ВМ из полученного baked-образа

## Основное задание

Запуск сборки:
```Bash
packer init config.pkr.hcl
packer build -var-file=variables.pkr.hcl ubuntu16.pkr.hcl
```

## Дополнительное 

Запуск сборки и создание ВМ:
```Bash
packer build -var-file=variables.pkr.hcl immutable.pkr.hcl
```
Далее перейти в каталог config-scripts и выполнить:
```Bash
./create-reddit-vm.sh
```


## ------------------------------------



# ДЗ №4

- Создание ВМ средствами yc cli
- Установка ruby, mongodb, git
- Запуск puma
- Автоматизация посредством скриптов
- Автоматизация посредством cloud-config

## Приложение

testapp_IP = 62.84.119.90

testapp_port = 9292

## Самостоятельная работа

Скрипты для упрощения деплоя приложения: install_ruby.sh, install_mongodb.sh, deploy.sh<br/>
Объединены в startup.sh

## Дополнительнае задание

Создание инстанса сразу с приложением: используется cloud-config файл startup.yaml <br/>
Запускается командой:

```Bash
yc compute instance create \
   --name reddit-app-2 \
   --hostname reddit-app-2 \
   --memory=4 \
   --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
   --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
   --metadata-from-file='user-data=startup.yaml' \
   --metadata serial-port-enable=1
```



## ------------------------------------



# ДЗ №3

- Использовался уже созданный аккаунт в яндекс облаке
- Созданы ВМ bastion (с внешним адресом) и someinternalhost (только с частным адресом)
- Созданы открытый/закрытый ключи для appuser и добавлены на ВМ
- Исследованы способы подключения к внутреннему хосту (someinternalhost) через SSH и Pritunl+OpenVPN
- Настроен let's encrypt сертификат в домене 158-160-49-203.sslip.io для Pritunl

## Подключение к someinternalhost в одну команду

```
ssh -J appuser@<ip> appuser@<internal_ip>
```

## дополнительное задание 1
Для подключения при помощи команды вида ssh someinternalhost необходимо добавить ~/.ssh/config:

```Bash
vim ~/.ssh/config

Host bastion
     HostName <ip_adress>
     User appuser
     IdentityFile ~/.ssh/appuser

Host someinternalhost
     HostName <ip_adress> #optional for ya cloud
     ProxyJump bastion
     User appuser
     IdentityFile ~/.ssh/appuser

```

## дополнительное задание 2
Не удалось воспользоваться nip.io из-за: too many certificates already issued for \"nip.io\", так что использовал sslip.io<br>
URL: https://158-160-49-203.sslip.io/

bastion_IP = 158.160.49.203
someinternalhost_IP = 10.128.0.27


