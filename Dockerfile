#========== Basic Image ==========
FROM java:8-jre-alpine
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
COPY lib/* 		/usr/lib64/
RUN  chmod 777 	/usr/lib64/libsigar-amd64-linux.so

#========== Configuration ==========

#========== Expose Ports ==========
EXPOSE 8080
EXPOSE 28080 

#========== RUN ==========
CMD /bin/sh