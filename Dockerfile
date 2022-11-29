# INSTALL PYTHON IMAGE
FROM apache/superset

USER root
# INSTALL TOOLS
RUN apt update \
    # gcc required for cx_Oracle
    && apt -y install gcc \
    && apt -y install unzip \
    && apt -y install libaio-dev sudo telnet curl\
    && mkdir -p /opt/data/api

ADD ./oracle-instantclient/ /opt/data
ADD ./install-instantclient.sh /opt/data
ADD ./requirements.txt /opt/data

WORKDIR /opt/data

ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include

# INSTALL INSTANTCLIENT AND DEPENDENCIES
RUN sudo bash install-instantclient.sh \
    && pip3 install -r requirements.txt

