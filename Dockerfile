FROM centos

# System Upgrade
# RUN yum -y upgrade   # disabled simply for speed in testing
RUN yum -y install httpd sed curl

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf && \
    sed -i 's/logs\/error_log/\/tmp\/error_log/' /etc/httpd/conf/httpd.conf && \
    sed -i 's/CustomLog "logs\/access_log" combined/CustomLog "\/tmp\/access_log" combined/' /etc/httpd/conf/httpd.conf

EXPOSE 8080

RUN echo "hello" > /var/www/html/index.html

RUN useradd -u 1001 -r -g 0 -s /sbin/nologin -c "Default Application User" default
RUN chown -R 1001:0 /run/httpd && \
    chmod g+rwx /run/httpd

USER 1001
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

