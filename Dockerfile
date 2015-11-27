FROM ubuntu
MAINTAINER Franco Leonardo Bulgarelli
RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install git -y
RUN git clone https://github.com/pepita-remembrance/cspec.git && cd cspec && make && make install
COPY bin/runcspec.sh /bin/runcspec
RUN chmod u+x /bin/runcspec
