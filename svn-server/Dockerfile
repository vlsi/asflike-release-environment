FROM alpine:3.20

RUN apk add --no-cache \
    apache2 \
    apache2-webdav \
    apache2-utils \
    mod_dav_svn \
    subversion

ARG SVN_NAME=
ARG EXTRA_SVN_DIRS=

ADD dav_svn.conf /etc/apache2/conf.d/dav_svn.conf

RUN mkdir -p /etc/subversion /home/svn /run/apache2 && \
    htpasswd -bc /etc/subversion/passwd test test && \
    [ -z "$SVN_NAME" ] || ( \
      svnadmin create /home/svn/dist && \
      printf '\nanon-access = read\nauth-access = write\n' >> /home/svn/dist/conf/svnserve.conf && \
      svnmucc -m 'Init' --root-url file:///home/svn/dist mkdir dev mkdir dev/$SVN_NAME mkdir release mkdir release/$SVN_NAME $EXTRA_SVN_DIRS && \
      chown -R apache:apache /home/svn/dist \
    )

EXPOSE 80 3960

CMD ["sh", "-c", "httpd -DFOREGROUND & exec svnserve --daemon --foreground --listen-port 3960 --root /home/svn"]
