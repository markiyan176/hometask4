#!/bin/bash

apt update -y

PASSWORD=$(openssl rand -base64 12)

HASH=$(openssl passwd -6 "$PASSWORD")

useradd -m -s /bin/bash adminuser
usermod -p "$HASH" adminuser
usermod -aG sudo adminuser

echo "adminuser password: $PASSWORD" > /root/adminuser_password.txt
chmod 600 /root/adminuser_password.txt

useradd -m -s /bin/bash poweruser
passwd -d poweruser

echo "poweruser ALL=(ALL) NOPASSWD: /usr/sbin/iptables" > /etc/sudoers.d/poweruser
chmod 440 /etc/sudoers.d/poweruser

usermod -aG adminuser poweruser

chmod 750 /home/adminuser

ln -s /etc/mtab /home/poweruser/mtab-link

systemctl restart sshd