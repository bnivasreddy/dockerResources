FROM java:8-jdk
MAINTAINER B. Laster (bclaster@nclasters.org)
# Mount point is /usr/src/project "docker run --rm -v /path/to/app:/usr/src/project gradle <command>")

RUN apk update && apk add libstdc++ && rm -rf /var/cache/apk/*

# Gradle
ENV GRADLE_VERSION 2.14.1

RUN cd /opt \
 && wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
 && unzip "gradle-${GRADLE_VERSION}-bin.zip" \
 && ln -s "/opt/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-${GRADLE_VERSION}-bin.zip"


# Set Appropriate Environmental Variables
ENV GRADLE_HOME /opt/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

RUN mkdir -p /home/diyuser
RUN echo 'diyuser::1002:0::/home/diyuser:/bin/bash' >> /etc/passwd

# Caches
VOLUME ["/home/diyuser/.gradle/caches", "/usr/src"]

WORKDIR /usr/src
# ENTRYPOINT ["/bin/bash"]



