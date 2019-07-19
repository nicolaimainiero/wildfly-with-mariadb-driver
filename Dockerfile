FROM jboss/wildfly:9.0.0.Final 

ADD org /opt/jboss/wildfly/modules/org/
ADD standalone.xml /opt/jboss/wildfly/standalone/configuration