#!/bin/bash

sudo apt update

sudo apt install -y python3 python3-pip python-pip htop stress-ng wget openssl build-essential libssl-dev git iperf libusb-1.0-0 libasound2 libcurl4-openssl-dev

git clone https://github.com/wg/wrk.git wrk

cd wrk && make && sudo cp wrk /usr/local/bin

cd ~/ && git clone https://github.com/jeffhammond/STREAM.git

cd STREAM/  && gcc -O2 -fopenmp stream.c -o ../stream

cd ~/ wget https://www.passmark.com/downloads/bitlinux.tar.gz && tar -xvf bitlinux.tar.gz
