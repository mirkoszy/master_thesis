#!/bin/bash

sudo apt update

sudo apt install -y python3 python3-pip python-pip htop stress-ng wget openssl build-essential libssl-dev git iperf

git clone https://github.com/wg/wrk.git wrk

cd wrk && make && sudo cp wrk /usr/local/bin

git clone https://github.com/jeffhammond/STREAM.git

cd STREAM/  && gcc -O2 -fopenmp stream.c -o ../stream

