#!/bin/bash

sudo sed -i -e 's/^bind_ip/#bind_ip/;' /etc/mongodb.conf
sudo systemctl restart mongodb
