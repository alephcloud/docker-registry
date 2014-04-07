# VERSION 0.1
# DOCKER-VERSION  0.7.3
# AUTHOR:         Sam Alba <sam@docker.com>
# AUTHOR:         Irene Knapp <irene.knapp@icloud.com>
# DESCRIPTION:    Image with docker-registry project and dependecies
# TO_BUILD:       docker build -rm -t registry .
# TO_RUN:         docker run -v /media/state/docker-registry:/media/host registry

FROM debian-stable

RUN apt-get update; \
    apt-get install -y git-core build-essential python-dev \
    libevent-dev python-openssl liblzma-dev python-pip; \
    rm /var/lib/apt/lists/*_*

ADD requirements.txt /docker-registry/
RUN cd /docker-registry && pip install -r requirements.txt

ADD . /docker-registry
ADD ./config/boto.cfg /etc/boto.cfg

RUN ln -s /media/host/config.yml /docker-registry/config/config.yml

EXPOSE 5000

CMD cd /docker-registry && exec ./run.sh
