ARG CENTOS_VERSION
FROM centos:${CENTOS_VERSION}
LABEL maintainer="ifui <ifui@foxmail.com>"

RUN groupadd -f www && useradd -g www www


# install pkg
RUN yum install -y wget \
    && yum install -y ca-certificates \
    && yum install -y openssh-server sudo\
    && yum install -y gd gcc-c++ libtirpc

COPY ./docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && sed -i "s/\r//" /entrypoint.sh

ARG BAOTA_INSTALL_PATH
ARG BAOTA_USERNAME
ARG BAOTA_PASSWORD

ENV BAOTA_INSTALL_PATH $BAOTA_INSTALL_PATH
ENV BAOTA_USERNAME $BAOTA_USERNAME
ENV BAOTA_PASSWORD $BAOTA_PASSWORD

ENTRYPOINT /entrypoint.sh $BAOTA_INSTALL_PATH $BAOTA_USERNAME $BAOTA_PASSWORD
