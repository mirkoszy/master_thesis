FROM ubuntu:bionic

RUN apt update

RUN apt install -y stress-ng wget openssl build-essential libssl-dev git iperf

RUN git clone https://github.com/wg/wrk.git wrk 

RUN cd wrk && make && cp wrk /usr/local/bin

RUN wget https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz && tar -xzf hpl-2.3.tar.gz
