ARG UBUNTU_VERSION=18.04

####################################
# Temporary image for building Duc #
####################################

FROM ubuntu:${UBUNTU_VERSION} AS build
LABEL maintainer="Maximilian Köstler <maximilian@koestler.dev>"

ARG DUC_VERSION=1.4.4

RUN apt-get update -qq \
 && apt-get install -qq --no-install-recommends \
        build-essential \
        checkinstall \
        libcairo2-dev \
        libncursesw5-dev \
        libpango1.0-dev \
        libtokyocabinet-dev \
        pkg-config \
        wget \
 && rm -rf /var/lib/apt/lists/*

ADD https://github.com/zevv/duc/releases/download/${DUC_VERSION}/duc-${DUC_VERSION}.tar.gz .

RUN tar xzf duc-${DUC_VERSION}.tar.gz \
 && cd duc-${DUC_VERSION} \
 && ./configure \
 && make \
 && checkinstall --install=no --default \
 && cp duc_${DUC_VERSION}-*.deb /duc.deb

###############################
# Final image for running Duc #
###############################

FROM ubuntu:${UBUNTU_VERSION}

COPY --from=build /duc.deb /

RUN dpkg -i /duc.deb \
 && rm /duc.deb

RUN apt-get update -qq \
 && apt-get install -qq --no-install-recommends \
        fcgiwrap \
        libcairo2 \
        libpango-1.0 \
        libpangocairo-1.0-0 \
        libtokyocabinet9 \
        nginx \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/www/html/*

COPY app/nginx.conf /etc/nginx/nginx.conf
COPY app/duc.cgi /var/www/html/duc.cgi

EXPOSE 80

STOPSIGNAL SIGTERM

CMD /etc/init.d/fcgiwrap start && nginx
