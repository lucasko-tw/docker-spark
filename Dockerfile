FROM java:8-jdk


# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv python-schedule && \
  rm -rf /var/lib/apt/lists/*


# Install System Tool
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip nano wget vim libmysqlclient-dev && \
  rm -rf /var/lib/apt/lists/* && \
  pip install py4j elasticsearch MySQL-python numpy


ENV SPARK_VERSION spark-2.0.2-bin-hadoop2.7

ADD http://d3kbcqa49mib13.cloudfront.net/$SPARK_VERSION.tgz /tmp/spark.tgz 

RUN tar -zxvf /tmp/spark.tgz  -C /usr/local &&  rm /tmp/spark.tgz

ENV SPARK_HOME="/usr/local/$SPARK_VERSION"
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

RUN mkdir /spark
WORKDIR /spark






