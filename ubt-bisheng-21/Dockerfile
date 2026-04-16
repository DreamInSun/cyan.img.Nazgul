# ========== Basic Image ==========
# 推荐使用 Eclipse Temurin 的官方镜像，基于 Ubuntu 20.04 (Focal Fossa)，包含 JRE 8。
FROM ubuntu:22.04

# 修正 MaintainerDeprecated: 使用 LABEL 替换 MAINTAINER
LABEL maintainer="DreamInSun"


ENV TZ=Asia/Shanghai
ENV LANG=C.UTF-8

# ========== Environment ==========
# 修正 LegacyKeyValueFormat: 将 'ENV key value' 改为 'ENV key=value' 或 'ENV key="value"'
ENV CONFIG_CONN="conf.xyan.xyz"
ENV SERVICE_NAME="cyan-img-Nazgul"
ENV SERVICE_VERSION="LTS"
ENV PROFILE="product"
ENV API_VERSION="3.0.0"
ENV JAVA_HOME="/opt/bisheng-jre-21.0.10"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# ========== Install ==========
# 切换到 Ubuntu 的包管理器 (apt)
# 更新包列表并安装所需工具：bash, curl, wget, tree, dmidecode, ca-certificates, tzdata
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        curl \
        tree \
        dmidecode \
        tzdata && \
    rm -rf /var/lib/apt/lists/*

# 设置时区并添加构建信息
RUN ln -sf /usr/share/zoneinfo/Hongkong /etc/localtime && \
    echo -ne "Nazgul Ubuntu:22.04&Bisheng-21-b13 image. (`uname -rsv`)\n" >> /root/.built

# ========== Add Library ==========
# 将本地压缩包添加到镜像并自动解压到 /opt 目录
ADD /bisheng-jre-21.0.10-b13-linux-x64/bisheng-jre-21.0.10 /opt/bisheng-jre-21.0.10

# ========== Configuration ==========

# ========== Expose Ports ==========
EXPOSE 8080
EXPOSE 28080

# ========== RUN ==========
# 修正 JSONArgsRecommended: 使用 JSON 数组格式（exec form）来指定 CMD
CMD ["/bin/bash"]