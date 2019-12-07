FROM elleflorio/svn-server@sha256:cbd1b55dcc6973e37850e1f80f8c66165a7fbd73c26c13bf832bc18e8c232388
#e53bba16bf71a53beb3bcf5ac48f0fcb4a7e77b97389cf004e20345e258536f7

RUN apk add --no-cache git-daemon
ARG EXTRA_SVN_DIRS=
ARG GIT_NAME=
ARG SVN_NAME=

ADD dav_svn.conf /etc/apache2/conf.d/dav_svn.conf

RUN svnadmin create /home/svn/dist &&\
    sed -i '/\[general\]/ a\n\
anon-access = none\n\
auth-access = write' /home/svn/dist/conf/svnserve.conf &&\
    chown -R apache:apache /home/svn/dist &&\
    htpasswd -b /etc/subversion/passwd test test &&\
    svnmucc -m 'Init' --root-url file:///home/svn/dist mkdir dev mkdir dev/$SVN_NAME mkdir release mkdir release/$SVN_NAME $EXTRA_SVN_DIRS

RUN mkdir /home/git/ &&\
    git config --global user.email 'test@example.com' &&\
    git init /home/git/empty.git && cd /home/git/empty.git && git commit --allow-empty --message "Initial commit" && git branch gh-pages && git branch asf-site &&\
    cd /home/git &&\
    git clone --bare empty.git $GIT_NAME.git &&\
    git clone --bare empty.git $GIT_NAME-site.git &&\
    git clone --bare empty.git $GIT_NAME-site-preview.git

ADD git/ /etc/services.d/git/

# DEFAULT_GIT_PORT

EXPOSE 9418
