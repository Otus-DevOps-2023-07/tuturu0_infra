# tuturu0_infra
tuturu0 Infra repository

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
     IdentityFile ~/.ssh/id_rsa

Host someinternalhost
     HostName <ip_adress> #optional for ya cloud
     ProxyJump bastion
     User appuser
     IdentityFile ~/.ssh/appuser

```

## дополнительное задание 2
Не удалось воспользоваться nip.io из-за: too many certificates already issued for \"nip.io\", так что использовал sslip.io<br>
URL: https://158-160-49-203.sslip.io/

- bastion_IP = 158.160.49.203
- someinternalhost_IP = 10.128.0.27
