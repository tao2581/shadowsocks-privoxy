FROM alpine:latest
MAINTAINER bluebu <bluebuwang@gmail.com>
RUN echo "http://mirrors.aliyun.com/alpine/v3.8/main/" > /etc/apk/repositories
#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

RUN \
  apk --update --upgrade add \
      python \
      libsodium \
      wget \
      py-pip \
      privoxy \
  && rm /var/cache/apk/*

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     51348
ENV PASSWORD        psw
ENV METHOD          rc4-md5
ENV PROTOCOL        origin
ENV PROTOCOL_PARAM  ""
ENV OBFS            http_simple
ENV OBFS_PARAM      23530-aLPl5t.download.microsoft.com
ENV TIMEOUT         300
ENV DNS_ADDR        8.8.8.8
ENV DNS_ADDR_2      8.8.4.4

ARG BRANCH=manyuser
ARG WORK=~


#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Install ShadowsocksR:
#------------------------------------------------------------------------------

RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksr-backup/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK

WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks

#------------------------------------------------------------------------------
# Expose ports and entrypoint:
#------------------------------------------------------------------------------
EXPOSE 8118 7070

ENTRYPOINT ["/entrypoint.sh"]
