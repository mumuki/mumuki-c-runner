FROM ubuntu
MAINTAINER Franco Leonardo Bulgarelli
RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install git -y
RUN git clone https://github.com/mumuki/cspec && cd cspec && git checkout 1.1.2 && make && make install

COPY runcspec.sh /bin/runcspec
RUN chmod u+x /bin/runcspec
