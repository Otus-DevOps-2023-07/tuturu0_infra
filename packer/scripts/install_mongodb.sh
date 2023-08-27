#!/bin/bash 

apt-get update -y && \
apt-get install -y mongodb && \
systemctl start mongodb && \
systemctl enable mongodb
