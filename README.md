# Homework 7

Создание fry, bakes образов при помощи packer. 
Был создан файл для packer с описание образа ubuntu16.json
В файле ubuntu16.json были использованы параметры обозначающие жесткий диск,
теги, название сети, описание образа.
Был создан файл для packer immutables.json. Образ собирается на основе ранее
созданного образа reddit-base. Для автозапуска приложению был создан сервис.
Был создан простой скрипт который создает инстанс из ранее "запеченого" образа

# Homework 6


gcloud compute instances create reddit-app2  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure   --zone=europe-west3-a --metadata "startup-script-url=https://raw.githubusercontent.com/Otus-DevOps-2017-11/epanoff_infra/Infra-2/startup_script.sh)"

# Homework 5

 1 Исследовать способ подключения к internalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения ивнести его в README.md в вашем репозитории
```
ssh -o ProxyCommand='ssh -i ~/.ssh/appuser -W %h:%p appuser@35.198.96.174' appuser@10.156.0.3
```
 Доп. задание: Предложить вариант решения для подключения из консоли при помощи команды вида ssh internalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу internalhost и внести его в README.md в вашем репозитории


Создать файл  ./ssh/config с содержимым
```
HOST bastion
    IdentityFile ~/.ssh/appuser
    User appuser
    HostName 35.198.96.174

HOST internalhost
    IdentityFile ~/.ssh/appuser
    User appuser
    HostName 10.156.0.3
    ProxyCommand ssh bastion -W %h:%p
```

 Опишите в README.md и в описании к Pull Request получившуюся конфигурацию и данные для
подключения.
```
Хост bastion, IP: 35.198.96.174, внутр. IP: 10.156.0.2
Хост: someinternalhost, внутр. IP: 10.156.0.3
```

