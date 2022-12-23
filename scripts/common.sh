#!/bin/bash

#java
JAVA_ARCHIVE=jdk-17.0.5_linux-x64_bin.tar.gz

#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_VERSION=hadoop-3.3.1
HADOOP_ARCHIVE=$HADOOP_VERSION.tar.gz
HADOOP_MIRROR_DOWNLOAD=https://mirrors.sonic.net/apache/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
HADOOP_RES_DIR=/vagrant/resources/hadoop
#HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop


#HIVE
HIVE_VERSION=apache-hive-1.2.1-bin
HIVE_ARCHIVE=$HIVE_VERSION.tar.gz
HIVE_MIRROR_DOWNLOAD=http://mirror.tcpdiag.net/apache/hive/stable/apache-hive-1.2.1-bin.tar.gz
HIVE_RES_DIR=/vagrant/resources/hive
HIVE_CONF_DIR=/usr/local/hive/conf