FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
	    build-essential git cmake sudo vim \
	    swig usbutils bison flex python-dev \
	    autoconf libtool pkg-config libssl-dev \
	    xfce4 xfce4-goodies tightvncserver \
	    net-tools
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser

COPY vncserver.sh /
ENTRYPOINT ["/vncserver.sh"]
