# Homework 9

Добавил resource "google_compute_firewall" "firewall_ssh"
Импортивал google_compute_firewall.firewall_ssh default-allow-ssh




# Homework 8

Практика IaC с использованием Terraform

1. Определите input переменную для приватного ключа,
использующегося в определении подключения для
провижинеров (connection);
2. Определите input переменную для задания зоны в ресурсе
"google_compute_instance" "app". У нее должно быть значение
по умолчанию;
3. Отформатируйте все конфигурационные файлы используя
команду terraform fmt;
4. Так как в репозиторий не попадет ваш terraform.tfvars, то
нужно сделать рядом файл terraform.tfvars.example, в котором
будут указаны переменные для образца.


Задание со звездочкой *
Какие проблемы вы обнаружили?
1) Наличие ключа в инстансе отлючает проектные ключи. Появляется галочка "Блокировать проектные SSH-ключи", которую нельзя отключить. 
Элемент пользовательских метаданных sshKeys блокирует SSH-ключи проекта.
2) Тераформ удалил созданный вручную ключ. 

Задание со звездочкой **

Создал балансировщик на основне модуля от гугла https://github.com/GoogleCloudPlatform/terraform-google-lb-http/tree/4d45fa0adc70803b611479d31a5ae6160f46f092/examples/basic

=======
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

