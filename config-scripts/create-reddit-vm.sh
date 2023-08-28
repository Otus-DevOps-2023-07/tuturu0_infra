#!/bin/bash

yc compute instance create \
  --name reddit-full-1 \
  --hostname reddit-full-1 \
  --zone=ru-central1-a \
  --create-boot-disk size=10GB,image-name=reddit-full-08-27-2023 \
  --cores=2 \
  --core-fraction=20 \
  --memory=2G \
  --network-interface subnet-name=default-ru-central1-a,ipv4-address=auto,nat-ip-version=ipv4
