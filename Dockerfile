#========== Basic Image ==========
# FROM java:8-jre-alpine
FROM frolvlad/alpine-oraclejdk8:cleaned
MAINTAINER "DreamInSun" 

#========== Environment ==========
ENV CONFIG_CONN       config.cyan.org.cn
ENV SERVICE_NAME      cyan-img-Nazgul
ENV SERVICE_VERSION   LTS
ENV PROFILE           product
ENV API_VERSION       1.1.2

#========== Install ==========
RUN apk add --no-cache --update-cache bash
RUN apk add --no-cache --update-cache curl tree tzdata \
    && cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime \
    && echo -ne "Nazgul Alpine:3.10&Java:8 image. (`uname -rsv`)\n" >> /root/.built

#========== Add Library ==========
#COPY lib/* 		/usr/lib64/
#RUN  chmod 777 	/usr/lib64/libsigar-amd64-linux.so

RUN set -ex \
	&& apk add -u --no-cache --virtual .build-deps \
		git gcc libc-dev make cmake libtirpc-dev pax-utils \
	&& mkdir -p /usr/src \
	&& cd /usr/src \
	&& git clone --branch sigar-musl https://github.com/ncopa/sigar.git \
	&& mkdir sigar/build \
	&& cd sigar/build \
	&& CFLAGS="-std=gnu89" cmake .. \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& make install \
	&& runDeps="$( \
		scanelf --needed --nobanner --recursive /usr/local \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)" \
	&& apk add --virtual .libsigar-rundeps $runDeps \
	&& apk del .build-deps \
	&& rm -rf /usr/src/sigar
	
#========== Configuration ==========

#========== Expose Ports ==========
EXPOSE 8080
EXPOSE 28080 

#========== RUN ==========
CMD /bin/sh