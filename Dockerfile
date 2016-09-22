FROM sebp/elk

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}

# Install plugins
RUN bin/plugin install license
RUN bin/plugin install shield

# Add specific role
COPY roles.yml /usr/share/elasticsearch/config/shield/

RUN bin/shield/esusers useradd es_admin -p es_admin -r admin