#!/bin/bash

nickname="$*"
if grep "127.0.0.1 $nickname.42.fr" /etc/hosts; then
    sudo sed -i "s/127.0.0.1 $nickname.42.fr//g" /etc/hosts
fi
