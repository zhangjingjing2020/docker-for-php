FROM centos:latest
MAINTAINER zhangjingjing <zhangjingjing2020@gmail.com>
#
ENV LANG   en_US.UTF-8
ENV LC_ALL en_US.UTF-8
WORKDIR /root
#
RUN alias ll='ls -l --color=auto'
RUN rpm -Uvh http://mirror.webtatic.com/yum/el7/epel-release.rpm
RUN rpm -Uvh http://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum install -y net-tools openssh openssh-server openssh-clients  tar gzip bzip2 wget
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown -R root:root /root && chmod 700 /root/.ssh
RUN echo 'root:1qaz#EDC890' | chpasswd
#
RUN yum install -y gcc gcc-c++ make autoconf mhash libmcrypt gd \
	pcre-devel
RUN yum clean all
#
EXPOSE 22
EXPOSE 80
#
CMD /usr/sbin/sshd -D
