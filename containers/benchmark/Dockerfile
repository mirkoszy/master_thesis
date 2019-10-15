FROM ubuntu:bionic

RUN apt update

RUN apt install -y time g++ pkg-config stress-ng wget openssl build-essential libssl-dev git iperf libcurl4-openssl-dev libasound2 libusb-1.0-0 libelf-dev bc

#RUN git clone https://github.com/wg/wrk.git wrk 

#RUN cd wrk && make && cp wrk /usr/local/bin

RUN git clone https://github.com/jeffhammond/STREAM.git

RUN cd STREAM/  && gcc -O2 -fopenmp stream.c -o ../stream

RUN git clone https://github.com/mirkoszy/master_thesis

RUN wget https://www.passmark.com/downloads/bitlinux.tar.gz && tar -xvf bitlinux.tar.gz

RUN wget https://github.com/knurd/kcbench/raw/master/kcbench && chmod +x kcbench

RUN wget https://github.com/filebench/filebench/archive/1.4.9.1.tar.gz && tar -xvf 1.4.9.1.tar.gz
