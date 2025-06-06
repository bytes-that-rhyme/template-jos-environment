# Use an Ubuntu LTS release
FROM ubuntu:noble-20250415.1
WORKDIR /root

# Add all needed packages here.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y build-essential libtool libglib2.0-dev libpixman-1-dev zlib1g-dev git libfdt-dev gcc-multilib gdb curl mtools dosfstools
RUN apt-get clean

#### Download, build, install, and test Python 2.7.18
RUN mkdir python
WORKDIR /root/python
RUN curl -L -o python.tgz https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
RUN tar --strip-components=1 -xzf python.tgz
RUN ./configure && make && make install
# Ensure that Python was installed correctly.
RUN python -c "import sys; sys.exit(0 if sys.version_info[0] == 2 and sys.version_info[1] >= 7 else 1)"
RUN rm -rf /root/python

#### Download, build, install, and test the special patched QEmu for JOS
WORKDIR /root
RUN git clone https://github.com/mit-pdos/6.828-qemu.git qemu
WORKDIR /root/qemu
RUN ./configure --disable-kvm --target-list="i386-softmmu x86_64-softmmu" --python=python2.7 --disable-werror
RUN --mount=type=bind,source=qemu.patch,target=/root/qemu/qemu.patch \
    git apply qemu.patch
RUN make && make install
RUN rm -rf /root/qemu

#### Set up development environment
COPY .gdbinit /root
COPY .bash_profile /root

