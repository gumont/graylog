#!/bin/bash
docker run --name graylog_mongo \
    -v /docker/graylog/mongo:/ \
    -d mongo:4.2
docker run --name graylog_elasticsearch \
    -e "http.host=0.0.0.0" \
    -e "discovery.type=single-node" \
    -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
    -v /docker/graylog/elasticsearch:/ \
    -d docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.2
docker run --name graylog_server --link graylog_mongo --link gryalog_elasticsearch \
    -p 9000:9000 -p 12201:12201 -p 1514:1514 -p 5555:5555 \
    -e GRAYLOG_HTTP_EXTERNAL_URI="http://127.0.0.1:9000/" \
    -v /docker/graylog/graylog_server:/ \
    -d graylog/graylog:4.0
