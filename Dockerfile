FROM centos
RUN yum install -y openssh-server
RUN yum install -y passwd
RUN rpm -e cracklib-dicts --nodeps; yum install -y cracklib-dicts
RUN echo d0cker | passwd --stdin root

## https://github.com/dotcloud/docker/issues/1240#issuecomment-21807183
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

## http://gaijin-nippon.blogspot.com/2013/07/audit-on-lxc-host.html
RUN sed -i -e '/pam_loginuid\.so/ d' /etc/pam.d/sshd

## add SSH keys
RUN mkdir -p /root/.ssh/
RUN curl https://github.com/2k0ri.keys >> /root/.ssh/authorized_keys

RUN yum update -y

ENV HOME /root

EXPOSE 22
CMD /sbin/init
