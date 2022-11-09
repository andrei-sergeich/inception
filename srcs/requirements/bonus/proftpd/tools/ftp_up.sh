#!/bin/sh

cmd="$@"

useradd "${FTP_USER}" -m && echo "${FTP_USER}:${FTP_PASS}" | chpasswd
usermod -aG root "${FTP_USER}"

echo "proFTPd started on :10021"

exec $cmd   # /usr/sbin/proftpd -n -c /etc/proftpd/cust_proftpd.conf
# TODO разобраться с удалением/переименованием файлов (проблема в правах при создании)