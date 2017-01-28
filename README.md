##Quick Start

```SH
docker pull lucasko/spark:latest

docker run -v $PWD:/spark -it lucasko/spark:latest  python SparkEgine.py
```


## Detail for Docker Spark

spark verion is spark-2.0.2-bin-hadoop2.7

### Dockerfile
```
FROM java:8-jdk

RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip nano wget vim libmysqlclient-dev  && \
  rm -rf /var/lib/apt/lists/*

#Install lib for common project
RUN pip install py4j elasticsearch MySQL-python numpy


ENV SPARK_VERSION spark-2.0.2-bin-hadoop2.7
ADD http://d3kbcqa49mib13.cloudfront.net/$SPARK_VERSION.tgz /tmp/spark.tgz
RUN tar -zxvf /tmp/spark.tgz  -C /usr/local 
RUN rm /tmp/spark.tgz

ENV SPARK_HOME="/usr/local/$SPARK_VERSION"
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

RUN mkdir /spark
WORKDIR /spark
```

### Build for Image
```
docker build -t spark:1.0  .  
```
### Run Container
```
docker run -v $PWD:/spark -it spark:1.0  python SparkEgine.py
```

```
Row(user=0, item=2, prediction=-0.13807)                            
Row(user=1, item=0, prediction=2.62584)
Row(user=2, item=0, prediction=-1.50184)
[[0, 2, -0.13807], [1, 0, 2.62584], [2, 0, -1.50184]]
```

