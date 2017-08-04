FROM ubuntu:16.10

# https://github.com/TofPlay/Dockerfiles/blob/master/install copy from here
COPY install /tmp/install
RUN chmod u+x /tmp/install 
RUN /tmp/install --source=apt --apt=vapor
RUN /tmp/install --source=apt --swift=3.1.1 
RUN /tmp/install --source=apt --vapor=2.0.3 
RUN /tmp/install --package=git --package=vim --package=tree
RUN /tmp/install --clean=true

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sqlite3 libsqlite3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/tomyhero/offline-viewer-demo ; cd offline-viewer-demo ; mkdir var ; vapor build

COPY start /tmp/start
RUN chmod u+x /tmp/start

CMD ["/tmp/start"]

