#!/bin/bash 

apt-get update -y && \
pkill -9 apt && \
apt-get install -y ruby-full ruby-bundler build-essential mongodb git && \
systemctl start mongodb && \
systemctl enable mongodb && \
mkdir /opt/reddit-full && \
cd /opt/reddit-full && \
git clone -b monolith https://github.com/express42/reddit.git && \
cd reddit && \
bundle install && \

tee /etc/systemd/system/reddit-full.service<<EOF
[Unit]
Description=reddit-full
Wants=network-online.target
After=network-online.target

[Service]
WorkingDirectory=/opt/reddit-full/reddit
ExecStart=/usr/local/bin/puma
Restart=always

[Install]
WantedBy=multi-user.target

EOF

systemctl daemon-reload && \
systemctl enable reddit-full && \
systemctl start reddit-full && \
systemctl status reddit-full
