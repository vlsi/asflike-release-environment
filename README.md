ASF-like release environment
============================

Apache Software Foundation [release process](http://www.apache.org/dev/release-publishing.html)
requires staging and publishing the artifacts via SVN.

Unfortunately, there's no test instances for SVN, Git, Nexus, and usage of production instances
for testing purposes might cause non-intended releases.

The purpose of the current scripts is to create throwaway release environment for testing purposes.


Usage
-----

1. Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/)
1. Boot the services: `docker-compose up`
1. Shut down docker images: `docker-compose stop`
1. All the services can be recreated (==all the deployed files are removed) via `./recreate.sh`

Switching TLPs
--------------

Differnet TLPs have different dist.apache.org structure, and by default only minimal set of folders is created

    ./recreate.sh calcite # Rebuild SVN image with Calcite folders, and restart services
    ./recreate.sh calcite-avatica # Rebuild SVN image with Calcite Avatica folders, and restart services
    ./recreate.sh jmeter # Rebuild SVN image with JMeter folders, and restart services
    ./recreate.sh javacc # Rebuild SVN image with JavaCC folders, and restart services
    ./recreate.sh darklaf # Rebuild SVN image with Darklaf folders, and restart services
    ./recreate.sh pgjdbc # Rebuild image with pgjdbc folders, and restart services

URLs
----

Note: Docker uses IPv4, so `localhost` might not work.

Login: `test`, password: `test`

* SVN web: http://127.0.0.1/svn
* SVN: svn://127.0.0.1:3960
* Nexus: http://localhost:8080/service/local/staging/profiles
* Git: git://127.0.0.1/
* Sonarqube: http://127.0.0.1:9000

License
-------

Apache License 2.0

Changelog
---------

2019-12-22
* Skip initialization of SVN server when SVN_NAME is empty

2019-12-07
* Allow to cusomize Git and SVN repository names

2019-11-15
* Readonly access to SVN repositories for anynymous users

2019-06-30
* Multi-environment mode (for different SVN layout)

2019-05-12
* Sonarqube
* Git server

2019-04-28
* Nexus stub via https://github.com/vlsi/nexus-stub

2019-04-16
* SVN repository

Author
------

Vladimir Sitnikov <sitnikov.vladimir@gmail.com>
