FROM alpine/git:v2.49.1

ARG GIT_NAME=

RUN apk --no-cache add git-daemon &&\
    mkdir /home/git/ &&\
    git config --global user.email 'test@example.com' &&\
    git init -b main /home/git/empty.git && cd /home/git/empty.git && git commit --allow-empty --message "Initial commit" && git branch gh-pages && git branch asf-site &&\
    cd /home/git &&\
    git clone --bare empty.git $GIT_NAME.git &&\
    git clone --bare empty.git $GIT_NAME-site.git &&\
    git clone --bare empty.git $GIT_NAME-site-preview.git

EXPOSE 9418

CMD ["daemon", "--base-path=/home/git", "--export-all", "--enable=receive-pack", "--reuseaddr", "--informative-errors", "--verbose", "--", "/home/git"]
