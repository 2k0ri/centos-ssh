FROM centos

ENV HOME /root

RUN rpm -e cracklib-dicts --nodeps
RUN yum install -y openssh-server cracklib-dicts passwd
RUN echo d0cker | passwd --stdin root

## https://github.com/dotcloud/docker/issues/1240#issuecomment-21807183
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

## http://gaijin-nippon.blogspot.com/2013/07/audit-on-lxc-host.html
RUN sed -i -e '/pam_loginuid\.so/ d' /etc/pam.d/sshd

## add SSH keys
RUN mkdir -p /root/.ssh/
RUN curl https://github.com/2k0ri.keys >> /root/.ssh/authorized_keys

# install chef
RUN curl -L https://www.opscode.com/chef/install.sh | bash

RUN yum update -y

EXPOSE 22
CMD /sbin/init
