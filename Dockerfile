#FROM golang:1.16
#
#WORKDIR /go/src
#ENV PATH="/go/bin:${PATH}"
#
#RUN apt-get update && \
#    apt-get install build-essential librdkafka-dev -y
#
#CMD ["tail", "-f", "/dev/null"]


FROM oraclelinux:8-slim

RUN  microdnf install oracle-instantclient-release-el8 && \
     microdnf install oracle-instantclient-basic oracle-instantclient-devel oracle-instantclient-sqlplus && \
     microdnf install tar gzip && \
     microdnf clean all

# Uncomment if the tools package is added
# ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin

#CMD ["sqlplus", "-v"]

RUN curl -O https://storage.googleapis.com/golang/go1.16.3.linux-amd64.tar.gz
RUN echo "951a3c7c6ce4e56ad883f97d9db74d3d6d80d5fec77455c6ada6c1f7ac4776d2  go1.16.3.linux-amd64.tar.gz" | sha256sum --check --status
RUN tar -C /usr/local/ -xzf go1.16.3.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

RUN useradd -ms /bin/bash app-user
WORKDIR /home/app-user

CMD ["tail", "-f", "/dev/null"]


#Execute a checksum and verify the result with what is mentioned on the golang download site.
#
#[root@jenkins-dev tmp]# sha256sum go1.8.linux-amd64.tar.gz
#53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca  go1.8.linux-amd64.tar.gz
#
#[root@jenkins-dev tmp]#
#
#Step 3
#Unpack the file into /usr/local
#
#[root@jenkins-dev tmp]# tar -C /usr/local/ -xzf go1.8.linux-amd64.tar.gz
#
#Step 4
#verify that go in in the right location
#
#[root@jenkins-dev tmp]# ls -la /usr/local/go
#total 168
#drwxr-xr-x  11 root root  4096 Feb 16 14:29 .
#drwxr-xr-x. 13 root root  4096 Mar  1 14:47 ..
#drwxr-xr-x   2 root root  4096 Feb 16 14:27 api
#-rw-r--r--   1 root root 33243 Feb 16 14:27 AUTHORS
#drwxr-xr-x   2 root root  4096 Feb 16 14:29 bin
#drwxr-xr-x   4 root root  4096 Feb 16 14:29 blog
#-rw-r--r--   1 root root  1366 Feb 16 14:27 CONTRIBUTING.md
#-rw-r--r--   1 root root 45710 Feb 16 14:27 CONTRIBUTORS
#drwxr-xr-x   8 root root  4096 Feb 16 14:27 doc
#-rw-r--r--   1 root root  5686 Feb 16 14:27 favicon.ico
#drwxr-xr-x   3 root root  4096 Feb 16 14:27 lib
#-rw-r--r--   1 root root  1479 Feb 16 14:27 LICENSE
#drwxr-xr-x  14 root root  4096 Feb 16 14:29 misc
#-rw-r--r--   1 root root  1303 Feb 16 14:27 PATENTS
#drwxr-xr-x   7 root root  4096 Feb 16 14:29 pkg
#-rw-r--r--   1 root root  1399 Feb 16 14:27 README.md
#-rw-r--r--   1 root root    26 Feb 16 14:27 robots.txt
#drwxr-xr-x  46 root root  4096 Feb 16 14:27 src
#drwxr-xr-x  17 root root 12288 Feb 16 14:27 test
#-rw-r--r--   1 root root     5 Feb 16 14:27 VERSION
#[root@jenkins-dev tmp]#
#
#Step 5
#add golang to your $path variable to make it available system wide and check if you can use go
#
#[root@jenkins-dev tmp]#
#[root@jenkins-dev tmp]# go --version
#-bash: go: command not found
#[root@jenkins-dev tmp]#
#[root@jenkins-dev tmp]# PATH=$PATH:/usr/local/go/bin
#[root@jenkins-dev tmp]#
#[root@jenkins-dev tmp]# go version
#go version go1.8 linux/amd64
