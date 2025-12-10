#!/bin/bash

apt update -y

useradd -m -s /bin/bash adminuser
echo "adminuser:1111" | chpasswd
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
chown poweruser:poweruser /home/poweruser/mtab-link
