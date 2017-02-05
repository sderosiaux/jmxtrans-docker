FROM java:openjdk-8-jre-alpine

WORKDIR /opt/jmxtrans

RUN apk --update add libc6-compat libstdc++ curl ca-certificates bash  \
	&& curl -sLO http://central.maven.org/maven2/org/jmxtrans/jmxtrans/263/jmxtrans-263-dist.tar.gz \
	&& tar zxvf jmxtrans-*-dist.tar.gz
	
VOLUME /opt/jmxtrans/conf 
VOLUME /opt/jmxtrans/log

ENTRYPOINT ["java", "-Djmxtrans.log.dir=/opt/jmxtrans/log", "-jar", "jmxtrans-263/lib/jmxtrans-all.jar", "-s", "10", "-f", "/opt/jmxtrans/conf/jmxtrans.conf"]
