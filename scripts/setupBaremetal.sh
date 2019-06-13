#!/bin/bash
echo setting up bare metal for Ubuntu

apt-get update -y && apt-get upgrade -y
apt-get install -y docker.io docker-compose
