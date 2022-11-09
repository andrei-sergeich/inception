#!/bin/bash

nickname="$*"
if ! grep "127.0.0.1 $nickname.42.fr" /etc/hosts; then
    echo -n "127.0.0.1 $nickname.42.fr" | sudo tee -a /etc/hosts
fi