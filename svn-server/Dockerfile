FROM garethflowers/svn-server:1.8@sha256:26688af47713ff4fea4c654ccdbfd86e50b2fe6e6d902c0e4b36249820095658
# elleflorio/svn-server@sha256:cbd1b55dcc6973e37850e1f80f8c66165a7fbd73c26c13bf832bc18e8c232388
#e53bba16bf71a53beb3bcf5ac48f0fcb4a7e77b97389cf004e20345e258536f7

RUN apk add --no-cache git-daemon
ARG EXTRA_SVN_DIRS=
ARG GIT_NAME=
ARG SVN_NAME=

ADD dav_svn.conf /etc/apache2/conf.d/dav_svn.conf

RUN [ -z "$SVN_NAME" ] || (svnadmin create /home/svn/dist &&\
    sed -i '/\[general\]/ a\n\
anon-access = none\n\
auth-access = write' /home/svn/dist/conf/svnserve.conf &&\
    chown -R apache:apache /home/svn/dist &&\
    htpasswd -b /etc/subversion/passwd test test &&\
    svnmucc -m 'Init' --root-url file:///home/svn/dist mkdir dev mkdir dev/$SVN_NAME mkdir release mkdir release/$SVN_NAME $EXTRA_SVN_DIRS ) || :
