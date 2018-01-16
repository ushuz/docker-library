# docker build . -t ushuz/spark:2.0.1

FROM openjdk:8-jre

# install py4j
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl unzip python \
 && curl -sL --retry 3 \
    "https://bootstrap.pypa.io/get-pip.py" \
    | python \
 && pip install py4j \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* $HOME/.cache

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# JAVA
ENV JAVA_HOME "/usr/lib/jvm/java-8-openjdk-amd64/jre"
RUN ln -s $JAVA_HOME /usr/java

# HADOOP
ENV HADOOP_VERSION 2.6.0
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
 && rm -rf $HADOOP_HOME/share/doc \
 && chown -R root:root $HADOOP_HOME

# SPARK
ENV SPARK_VERSION 2.0.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://d3kbcqa49mib13.cloudfront.net/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME

# run as hadoop user
RUN useradd -Ms /bin/bash hadoop

USER hadoop
WORKDIR $SPARK_HOME

CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
