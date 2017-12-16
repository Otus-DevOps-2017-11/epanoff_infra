# 1 Исследовать способ подключения к internalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения ивнести его в README.md в вашем репозитории
```
ssh -o ProxyCommand='ssh -i ~/.ssh/appuser -W %h:%p appuser@35.198.96.174' appuser@10.156.0.3
```
# Доп. задание: Предложить вариант решения для подключения из консоли при помощи команды вида ssh internalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу internalhost и внести его в README.md в вашем репозитории


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

# 3. Опишите в README.md и в описании к Pull Request получившуюся конфигурацию и данные для
подключения.
```
Хост bastion, IP: 35.198.96.174, внутр. IP: 10.156.0.2
Хост: someinternalhost, внутр. IP: 10.156.0.3
```


