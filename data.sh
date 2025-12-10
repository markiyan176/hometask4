#!/bin/bash

apt update -y

ADMIN_PASS=$(openssl rand -base64 12)
echo "Password: $ADMIN_PASS"

ADMIN_HASH=$(openssl passwd -6 "$ADMIN_PASS")

useradd -m -s /bin/bash adminuser
echo "adminuser:${ADMIN_HASH}" | chpasswd -e
usermod -aG sudo adminuser

useradd -m -s /bin/bash poweruser
passwd -d poweruser

echo "poweruser ALL=(ALL) NOPASSWD: /usr/sbin/iptables" > /etc/sudoers.d/poweruser
chmod 440 /etc/sudoers.d/poweruser

sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config

systemctl restart sshd

chmod 750 /home/adminuser
chgrp poweruser /home/adminuser

ln -s /etc/mtab /home/poweruser/mtab-link

