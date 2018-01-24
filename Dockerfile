# 基于镜像的名称
FROM hub.c.163.com/tskshy/debian

# 维护者信息
MAINTAINER tanshuai

# 基础组件安装
RUN /bin/bash -c '\
echo -e "deb http://mirrors.163.com/debian/ stretch main\ndeb-src http://mirrors.163.com/debian/ stretch main\ndeb http://security.debian.org/debian-security stretch/updates main contrib\ndeb-src http://security.debian.org/debian-security stretch/updates main contrib\ndeb http://mirrors.163.com/debian/ stretch-updates main contrib\ndeb-src http://mirrors.163.com/debian/ stretch-updates main contrib" > /etc/apt/sources.list && \
apt-get update && \
apt-get install -y apt-utils ssh vim && \
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
echo "root:shallbyetoo" | chpasswd && \
touch /run.sh && \
chmod +x /run.sh && \
mkdir /var/run/sshd && \
echo -e "#!/usr/bin/env bash\n/usr/sbin/sshd -D" >> /run.sh \
'

#EXPOSE 22
CMD ["/run.sh"]
