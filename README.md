# Wildfly 9.0.0.Final with MariaDB Connector/J

This repository provides an Wildfly 9.0.0.Final with preinstalled MariaDB Connector/J JDBC driver as module.

## Build

```
docker build --rm --tag wildfly-with-mariadb-driver .
```

## Run

```
docker run --name="wildfly" -d -p 8080:8080 -p 9990:9990 \
    -e DATASOURCE_JNDI_NAME="java:jboss/datasources/MyDataSourceDS" \
    -e MARIADB_CONNECTION_URL="jdbc:mariadb://host:3306/mydatabase" \
    -e MARIADB_USER="myuser" \
    -e MARIADB_PASSWORD="mypassword" \
       nicolaimainiero/wildfly-with-mariadb-driver

```

## docker-compose example
This `docker-compose.yaml`configures a mariadb container and a wildfly container. It defines a common network called `backend`. 
```
version: '2'
services:
  mariadb:
    image: mariadb
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: 'root'
      MYSQL_DATABASE: 'mydatabase'
      MYSQL_USER: 'myuser'
      MYSQL_PASSWORD: 'mypassword'
    networks:
      - backend

mywildflyservice:
  image: nicolaimainiero/wildfly-with-mariadb-driver
  environment:
    DATASOURCE_JNDI_NAME: "java:jboss/datasources/MyDataSourceDS"
    MARIADB_CONNECTION_URL: "jdbc:mariadb://mariadb:3306/mydatabase"
    MARIADB_USER: "myuser"
    MARIADB_PASSWORD: "mypassword"
  ports:
    - "8080:8080"
    - "9990:9990"
networks:
  backend:
    driver: bridge