# ========== Basic Image ==========
# 推荐使用 Eclipse Temurin 的官方镜像，基于 Ubuntu 20.04 (Focal Fossa)，包含 JRE 8。
FROM eclipse-temurin:8-jre-focal

# 修正 MaintainerDeprecated: 使用 LABEL 替换 MAINTAINER
LABEL maintainer="DreamInSun"

# ========== Environment ==========
# 修正 LegacyKeyValueFormat: 将 'ENV key value' 改为 'ENV key=value' 或 'ENV key="value"'
ENV CONFIG_CONN="config.cyan.org.cn"
ENV SERVICE_NAME="cyan-img-Nazgul"
ENV SERVICE_VERSION="LTS"
ENV PROFILE="product"
ENV API_VERSION="1.1.5"

# ========== Install ==========
# 切换到 Ubuntu 的包管理器 (apt)
# 更新包列表并安装所需工具：bash, curl, tree, dmidecode
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
    echo -ne "Nazgul Ubuntu:20.04&Java:8 image. (`uname -rsv`)\n" >> /root/.built

# ========== Add Library ==========
# 将 libsigar-amd64-linux.so 复制到 /usr/lib64/
COPY lib/* /usr/lib64/
RUN chmod 777 /usr/lib64/libsigar-amd64-linux.so


# ========== Configuration ==========

# ========== Expose Ports ==========
EXPOSE 8080
EXPOSE 28080

# ========== RUN ==========
# 修正 JSONArgsRecommended: 使用 JSON 数组格式（exec form）来指定 CMD
CMD ["/bin/bash"]