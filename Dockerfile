# ---- xPatterns Java Docker ----

# ---- Version Control ----

FROM xpatterns/base
ENV DOWNLOAD_LINK http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz

# ---- Set Environmental Variables ----

ENV JAVA_VERSION jdk1.7.0_79
ENV JRE_HOME /usr/lib/jvm/$JAVA_VERSION
ENV JAVA_HOME /usr/lib/jvm/$JAVA_VERSION
ENV PATH="$PATH:${JAVA_HOME}/bin"

# ---- Setup Environment file ----

RUN echo "JRE_HOME=${JRE_HOME}" >> /etc/environment
RUN echo "JAVA_HOME=${JAVA_HOME}" >> /etc/environment
RUN sed -i '/PATH/c\PATH='"'$PATH:${JAVA_HOME}/bin\'"'' /etc/environment

# ---- apt-get ----

RUN apt-get update && apt-get install -y \
	wget

# ---- Setup Java ----

RUN rm -Rf /tmp/*
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $DOWNLOAD_LINK -P /tmp
RUN mkdir -p /usr/lib/jvm
RUN tar xzf /tmp/*.tar.gz -C /usr/lib/jvm/
RUN chmod -R 755 /usr/lib/jvm/$JAVA_VERSION
RUN rm -Rf /tmp/*
