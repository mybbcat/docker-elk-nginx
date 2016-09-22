FROM sebp/elk

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}

# The shield plugin configuration must be in ES_HOME/config
RUN cat config/elasticsearch.yml > /etc/elasticsearch/elasticsearch.yml
RUN rm -rf config
RUN ln -s /etc/elasticsearch/ config

# Install plugins
RUN gosu elasticsearch bin/plugin install license
RUN gosu elasticsearch bin/plugin install shield

# Add specific role
COPY roles.yml /usr/share/elasticsearch/config/shield/

ENV LOGSTASH_PWD logstash
ENV KIBANA_PWD kibana
ENV KIBANA_USER_NAME kibana
ENV KIBANA_USER_PWD kibana

COPY es-entrypoint.sh /
ENTRYPOINT ["/es-entrypoint.sh"]