FROM elleflorio/svn-server:latest

RUN apk add --no-cache git-daemon
ARG PROJECT_NAME=jmeter

RUN svnadmin create /home/svn/dist &&\
    chown -R apache:apache /home/svn/dist &&\
    htpasswd -b /etc/subversion/passwd test test &&\
    svnmucc -m 'Init' --root-url file:///home/svn/dist mkdir dev mkdir dev/$PROJECT_NAME mkdir release mkdir release/$PROJECT_NAME mkdir release/$PROJECT_NAME/binaries mkdir release/$PROJECT_NAME/sources

RUN mkdir /home/git/ &&\
    git config --global user.email 'test@example.com' &&\
    git init /home/git/empty.git && cd /home/git/empty.git && git commit --allow-empty --message "Initial commit" && git branch gh-pages && git branch asf-site &&\
    cd /home/git &&\
    git clone --bare empty.git $PROJECT_NAME.git &&\
    git clone --bare empty.git $PROJECT_NAME-site.git &&\
    git clone --bare empty.git $PROJECT_NAME-preview.git

ADD git/ /etc/services.d/git/

# DEFAULT_GIT_PORT

EXPOSE 9418
