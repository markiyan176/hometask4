Ferendovych Markiyan 4CS-31

```
./run.sh - запуск інстанса
ssh -i key-pair.pem ubuntu@<ip> - підключення до інстансу
su - adminuser - увійти в користувача adminuser
su - poweruser - увійти в користувача poweruser
sudo cat /var/log/cloud-init-output.log | grep "Password" - показує пароль до adminuser

```