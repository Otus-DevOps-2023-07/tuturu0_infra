#!/bin/bash

apt-get update -y && \
pkill -9 apt && \
apt-get install -y mongodb && \
systemctl start mongodb && \
systemctl enable mongodb
