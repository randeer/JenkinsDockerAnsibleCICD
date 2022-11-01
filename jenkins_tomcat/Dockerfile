FROM tomcat:9.0

RUN cp -r webapps.dist/* webapps/*

COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml