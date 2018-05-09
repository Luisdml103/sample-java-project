FROM openjdk:8-jdk-alpine

ENV ANT_VERSION=1.10.3 \
    IVY_VERSION=2.5.0

COPY . /opt/code 
WORKDIR /opt/code

RUN mkdir /opt/ant && \
    #Getting the dependencies for build the project
    wget "http://www-us.apache.org/dist//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz" -O "/tmp/ant_${ANT_VERSION}.tar.gz" && \ 
    tar -xf "/tmp/ant_${ANT_VERSION}.tar.gz" --strip-components=1 -C /opt/ant && \
    wget "http://www-us.apache.org/dist//ant/ivy/${IVY_VERSION}-rc1/apache-ivy-${IVY_VERSION}-rc1-bin.tar.gz" -O "/tmp/ivy_${IVY_VERSION}.tar.gz" && \ 
    tar -xf "/tmp/ivy_${IVY_VERSION}.tar.gz" -C /opt && \
    cp "/opt/apache-ivy-${IVY_VERSION}-rc1/ivy-${IVY_VERSION}-rc1.jar" "/opt/ant/lib" && \

    rm -rf "/opt/apache-ivy-${IVY_VERSION}-rc1" && \
    rm "/tmp/ant_${ANT_VERSION}.tar.gz" && \
    rm "/tmp/ivy_${IVY_VERSION}.tar.gz" && \
    #Build the project
    /opt/ant/bin/ant

ENTRYPOINT ["/bin/sh", "run.sh"]
CMD []
