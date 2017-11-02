FROM alpine
MAINTAINER Franco Leonardo Bulgarelli

RUN apk add --no-cache build-base git && \
    git clone https://github.com/mumuki/cspec && cd cspec && git checkout 1.1.2 && make && make install && \
    apk del git

COPY runcspec.sh /bin/runcspec
RUN chmod u+x /bin/runcspec
