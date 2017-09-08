FROM ubuntu:16.04

RUN sed -i 's/archive.ubuntu.com/mirrors.yun-idc.com/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get upgrade -y && \
  ls

RUN apt-get install wget -y

RUN apt-get install -y python-software-properties software-properties-common 

RUN apt-get install -y unzip curl jq docker.io

ENV TZ 'Asia/Shanghai'
RUN echo $TZ > /etc/timezone && \
  apt-get update && apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

ENV NODE_PKG_NAME node-v6.9.1-linux-x64
ENV PHANTOMJS_CDNURL http://npm.taobao.org/phantomjs
ENV NODEJS_ORG_MIRROR https://npm.taobao.org/mirrors/node

COPY ./soft/* /opt/
COPY ./bzip2_1.0.6-8_amd64.deb /opt/

RUN cd /opt && \
  dpkg -i bzip2_1.0.6-8_amd64.deb

RUN apt-get install libfontconfig1 -y

# Install node.
RUN cd /opt && \
  tar -xzvf $NODE_PKG_NAME.tar.gz && \
  rm -f $NODE_PKG_NAME.tar.gz && \
  mv $NODE_PKG_NAME node

ENV NODE_HOME /opt/node
ENV PATH $NODE_HOME/bin:$PATH/

## Install yarn
RUN \
  npm config set registry https://registry.npm.taobao.org && \
  npm install -g yarn

ENV PATH /opt/pm/node_modules/.bin:$PATH/

RUN apt-get install net-tools -y && \
  apt-get install iputils-ping -y
