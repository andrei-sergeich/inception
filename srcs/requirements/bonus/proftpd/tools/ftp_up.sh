#!/bin/sh

cmd="$@"
# TODO разобраться с переменными и с удалением/переименованием файлов
#useradd "${FTP_USER}" -m && echo "${FTP_USER}:${FTP_PASS}" | chpasswd
#usermod -aG root "${FTP_USER}"

useradd cmero_ftp -m && echo "cmero_ftp:cmero_ftp_pass" | chpasswd
usermod -aG root cmero_ftp

echo "proFTPd started on :10021"

exec $cmd   # /usr/sbin/proftpd -n -c /etc/proftpd/cust_proftpd.conf
#exec proftpd -n -c /etc/proftpd/cust_proftpd.conf