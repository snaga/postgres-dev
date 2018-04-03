FROM centos:7
MAINTAINER Satoshi Nagayasu <snaga@uptime.jp>

# dev tools and deps
RUN yum install -y git gcc make bison bison-devel flex flex-devel readline readline-devel zlib zlib-devel

# LLVM stuff
ADD epel-copr.repo /tmp

RUN yum install -y epel-release && \
    cat /tmp/epel-copr.repo >> /etc/yum.repos.d/epel.repo && \
    yum install -y llvm-3.9.0-devel clang-3.9.0-devel

RUN git clone https://git.postgresql.org/git/postgresql.git

RUN pushd postgresql && \
      git log -1 && \
      ./configure --prefix=/usr/local/pgsql --enable-debug \
        --with-llvm \
        LLVM_CONFIG=/opt/llvm-3.9.0/bin/llvm-config-64 \
        CLANG=/opt/llvm-3.9.0/bin/clang && \
      make && \
      make install && \
    popd

RUN pushd postgresql/contrib && \
      make && \
      make install && \
    popd

RUN groupadd postgres && \
    adduser -g postgres postgres && \
    mkdir -p /var/lib/pgsql/11/data && \
    chown -R postgres:postgres /var/lib/pgsql

ADD start.sh /

USER postgres

CMD ["/start.sh"]
