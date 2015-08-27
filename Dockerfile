FROM 172.16.83.159:5000/rhel7.1:latest

MAINTAINER “AMIT SHARMA” <amit@redhat.com>

RUN rm -f /etc/yum.repos.d/*
ADD rhel7.repo /etc/yum.repos.d/
RUN yum repolist

#ENV container docker

RUN yum -y install deltarpm yum-utils
RUN yum -y install httpd procps-ng MySQL-python wget vim-enhanced net-tools

# Add configuration file
ADD action /var/www/cgi-bin/action
#RUN echo "PassEnv DB_SERVICE_SERVICE_HOST" >> /etc/httpd/conf/httpd.conf
RUN chown root:apache /var/www/cgi-bin/action
RUN chmod 755 /var/www/cgi-bin/action

RUN echo "ServerName someserver.com" >> /etc/httpd/conf/httpd.conf
RUN echo "Pidfile /tmp/httpd.pid" >> /etc/httpd/conf/httpd.conf

RUN echo "The Web Server is Running" > /var/www/html/index.html

EXPOSE 8080 80

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]

#CMD ["/usr/sbin/httpd -k start"]
