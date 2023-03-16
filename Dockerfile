FROM registry.fedoraproject.org/fedora:37

RUN dnf -y install gcc gcc-c++ glibc-devel

RUN mkdir -p /opt/toolchain/usr/`gcc -dumpmachine`/usr/lib

RUN cp -R /usr/lib/gcc /opt/toolchain/usr/`gcc -dumpmachine`/usr/lib/

RUN for f in `dnf -q repoquery -l glibc-devel`; do echo $f && mkdir -p /opt/toolchain/usr/`gcc -dumpmachine`/`dirname $f` && cp $f /opt/toolchain/usr/`gcc -dumpmachine`/$f; done

RUN for f in `dnf -q repoquery -l glibc` `dnf -q repoquery -l libgcc`; do if [ `dirname $f` == "/lib64" ]; then echo $f && mkdir -p /opt/toolchain/usr/`gcc -dumpmachine`/`dirname $f` && cp $f /opt/toolchain/usr/`gcc -dumpmachine`/$f; fi; done
