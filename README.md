# tuturu0_infra
tuturu0 Infra repository


# ДЗ №10


- Созданы роли app и db
- Созданы окружения stage и prod
- Использована коммьюнити роль jdauphant nginx для настройки обратного прокси на 80м порту
- Использован ansible Vault для шифрования чувствительных файлов



## ------------------------------------



# ДЗ №9


- Создание плейбука с одним сценарием (для приложения, базы и деплоя)
- Создание плейбука с множеством сценариев (для приложения, базы и деплоя)
- Создание раздельных плейбуков (для приложения, базы и деплоя)
- Изменение скрипта для динамического инвентаря
- Изменение провиженеров в packer и сборка новых образов с использованием ansible
- Деплой приложения на новых образах



## Дополнительные задания:
## Использовать dynamic inventory для Yandex Cloud в этом задании и исследовать функционал keyed_groups:
Для динамического инвентаря изменил переменную app в inventory.sh, чтобы она возвращала ВМ в статусе running
```Bash
app=$(yc compute instance list | grep RUNNING | awk -F '|' '{print $6}' | awk '{$1=$1};1')
```
Касательно keyed_groups: ознакомился с документацией, однако в рамках данной задачи не нашёл применения


## Обновлённый провижининг в Packer:
Изменённые файлы можно посмотреть в каталоге packer: app.pkr.hcl, app.json, db.pkr.hcl, db.json<br/>
Запуск:
```Bash
packer build -var-file=variables.pkr.hcl app.pkr.hcl
packer build -var-file=variables.pkr.hcl db.pkr.hcl
terraform plan
terraform apply
ansible-playbook site.yml
```






## ------------------------------------



# ДЗ №8


- Установлен ansible
- Созданы инвентарники в форматах .ini; .yml; .json и скрипт для генерации автоматического
- Создан простой playbook
- Опробованы модули ansible

## Для использования статического .json инвентаря:
```Bash
ansible all -i ./inventory.json -m ping
ansible-playbook -i ./inventory.json clone.yml
```


## Для использования динамического .json инвентаря:
```Bash
ansible-playbook clone.yml # т.к. .sh указан в ansible.cfg
ansible-playbook -i ./inventory.sh clone.yml # но можно и так
```


## ------------------------------------



# ДЗ №7


- Созданы ВМ для приложения и базы в packer
- Созданы модули app и db
- Созданы окружения stage и prod
- Создан backend для вынесения state в бакет (дополнительное задание)
- Приложение и база разнесены по разным инстансам (дополнительное задание)

## Для вынесения state в бакет необходимо:
- Создать бакет
- Создать статический ключ доступа
- Выполнить init
```Bash
terraform init -backend-config="access_key=идентификатор_ключа" -backend-config="secret_key=секретный_ключ"
```

## Для разнесения приложения и БД по разным ВМ нужно:
Добавить в unit-файл puma адрес базы
```Bash
Environment='DATABASE_URL=${internal_ip_address_db}'
```
Переменная internal_ip_address_db определяется в provisioner модуля app
```Bash
provisioner "file" {
    content     = templatefile("${path.module}/puma.service", { internal_ip_address_db = "${var.db_ip}" })
    destination = "/tmp/puma.service"
  }
```
Для открытия доступа к базе на ВМ с ней выполняется
```Bash
#!/bin/bash

sudo sed -i -e 's/^bind_ip/#bind_ip/;' /etc/mongodb.conf
sudo systemctl restart mongodb
```


## ------------------------------------



# ДЗ №6

- Установка terraform с зеркала yandex
- Настрокйка конфигурационного файла terraform
- Настройка файлов переменных
- Написание конфига для баллансировщика
- Создание таргет группы для балансировщика

```Bash
terraform init
terraform plan -var-file==terraform.tfvars
terraform apply -var-file==terraform.tfvars
```
Основное задание: main.tf</br>
Дополнительное задание: lb.tf</br>

## Секция terraform закоментирована для прохождения теста

## ------------------------------------



# ДЗ №5

- Установка packer с зеркала yandex
- Настрокйка конфигурационного файла packer
- Вынесение переменных в отдельный файл и добавление новых параметров
- Написание конфига и скрипта для создания baked-образа с демоном реддита
- Написание скрипта для содания ВМ из полученного baked-образа

## Заупск с вынесенными переменными

Запуск сборки:
```Bash
packer init config.pkr.hcl
packer build -var-file=variables.pkr.hcl ubuntu16.pkr.hcl
```

## автоматизация

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
