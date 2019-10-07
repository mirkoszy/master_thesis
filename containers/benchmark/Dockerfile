FROM ubuntu:bionic

RUN apt update

RUN apt install -y g++ pkg-config stress-ng wget openssl build-essential libssl-dev git iperf

RUN git clone https://github.com/wg/wrk.git wrk 

RUN cd wrk && make && cp wrk /usr/local/bin

RUN git clone https://github.com/jeffhammond/STREAM.git

RUN cd STREAM/  && gcc -O2 -fopenmp stream.c -o ../stream
