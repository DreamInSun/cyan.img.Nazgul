cyan.img.Nazgul
CYAN 基础镜像 Nazgul容器

====================
 

====================
### 部署脚本 
```

====================
### 运行命令


====================
## 历史版本

###1.0.0
* 优化了Nazgul的默认时间，使用/usr/share/zoneinfo/Hongkong时区

### 1.1.0
* 增加了sigar库

### 1.1.1
* sigar库添加了运行权限

### 1.1.2
* 调整了Sigar库位置

### 1.1.3
* 修改了libsigar安装方式

### 1.1.4
* 更换了基础镜像frolvlad/alpine-oraclejdk8:cleaned，使用glibc,兼容更多本地库

### 1.1.5
* 更换使用lib中的库替代编译库

### 1.1.6
* 增加了dmidecode

### 1.1.7
* 优化了dmidecode安装的位置

### 1.2.0
* 更换了基础镜像frolvlad/alpine-java:jre8-cleaned 因为oraclejdk8镜像关闭了