# Homework 12
ansible

Перенес плейбуки в раздельные роли 
Описал две среды stash и prod (различиются только в env переменных на данный 
момент)

Импортировал и применил коммьюнити роль nginx jdauphant.nginx

На каждом этапе проверял работу полным перезапуском окружения.

#*
На в задании 11 изучил gce.py. В этом изменил в ansible.cfg строчку
 inventory = ./old/gce.py
Плюс измененил названия в terrarome - вместо reddit-app => app чтоб матчились названия

#*



# Homework 11

Создал плейбук ansible/reddit_app_one_play.yml для конфигурации и деплоя приложения
Создал плейбук  ansible/reddit_app_multiple_plays.yml - для того же плюс БД. Для правильной установки нужно запускать
с правильными тагами. 
Разделил ansible/reddit_app_multiple_plays.yml на несколько ролей.
Все позапускал - все работают. 

Под звездочкой изучил возможности gce.py для созданрия динамического инвентори

Создал плейбуки для пакера. Создал новые образы. 
Все работает. 
Плюс пришлось увеличить вывод output для терраформа для удобства.




# Homework 10
Установил ansible. Создал inventory в разныъ форматах ini, yuml
Позапускал разные модули ping, shell, command

# *
Не знай зачем запретили использовать gce.py. Свой аналог писать не хотелось
поэтому наговнокодил write-only script

echo `echo "{";gcloud compute instances list  
| grep -v "STATUS"| awk '{printf "\"%s\"\:\{\"hosts\"\:{ \"%s\" :{\"ansible_host\":\"%s\"}}},", $1, $1, $5 }'| sed s'/.$//';echo "}"`  > inventory.json

Он рабочий. Проверено. Но я бы лучше использовал gce.py чем это поделие. 


# Homework 9

Добавил resource "google_compute_firewall" "firewall_ssh"
Импортивал google_compute_firewall.firewall_ssh default-allow-ssh
Добавил google_compute_address. Привязал их к app инстансам.  В процессе наткнулся на то что в прошлом задании у меня уже было два инстанса плюс балансировщик и уперся в лимиты
Поэтому отказался от второго инстанса и балансивщика. (Потом в задании есть требования удалить лишние сущиности)
Скопировал файл ubuntu16.json в app.json и db.json. Удалил лишнее и добавил в название app и db соответсвенно
Создал на основа app.json и db.json новые образы пакером.
Создал и проверил разбиение на app и db сервер.
Переместил новые app.tf и db.tf в новые модули.
Разделил среды на prod и на stage с разным доступом.
# *
state файл сделал на GCS при помощи файла backend.tf
Если запустить одновременно apply то во втором случае будет ошибка вида
Error loading state: writing "gs://infra-189214/terraform.tflock" failed
значит работает
# *
Добавил провижионер для app. Для бд не нужно там и так mongodb в автозагрузке
Но понять почему puma не видит БД так и не смог. Наверное что-то упустил.  

UPDATED: теперь все видит - все работает
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

