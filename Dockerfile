FROM centos:latest

#Define the ENV variable
ENV nginx_vhost /etc/nginx/sites-available/default
ENV repo_nfs /usr/share/nginx
ENV nginx_conf /etc/nginx/nginx.conf

VOLUME ["/usr/share/nginx"]
EXPOSE 80

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install nfs-utils nginx createrepo inotify-tools yum-utils git && \
    yum clean all

RUN mkdir -p /usr/share/nginx/html \
             /usr/share/nginx/html/repos/base \
             /usr/share/nginx/html/repos/centossplus \
             /usr/share/nginx/html/repos/extras \
             /usr/share/nginx/html/repos/updates
             
RUN cd /usr/share && git clone https://github.com/mkouhei/watchrepo.git

CMD /usr/share/watchrepo/watchrepo.sh /usr/share/nginx/html/repos
