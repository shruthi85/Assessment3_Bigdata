#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalHadoop {
	echo "install hadoop from local file"
	# unzip and move to /usr/local/bin/hadoop
	FILE=/vagrant/resources/$HADOOP_ARCHIVE
	tar -xzf $FILE -C /usr/local/
	sudo mv /usr/local/hadoop-3.3.1 /usr/local/hadoop/
}

function setupHadoop {
	echo "creating hadoop directories"
	sudo mkdir /var/hadoop
	sudo mkdir /var/hadoop/hadoop-datanode
	sudo mkdir /var/hadoop/hadoop-namenode
	sudo mkdir /var/hadoop/mr-history
	sudo mkdir /var/hadoop/mr-history/done
	sudo mkdir /var/hadoop/mr-history/tmp
	sudo mkdir /var/hadoop_logs
	sudo chmod 777 /var/hadoop/hadoop-datanode
	sudo chmod 777 /var/hadoop/hadoop-namenode
	sudo chmod 777 /var/hadoop_logs	
}


function installHadoop {
		installLocalHadoop
}

echo "setup hadoop"
installHadoop
setupHadoop

# copy core-site.xml file
echo "copying files xml"
sudo cp /vagrant/resources/hadoop/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
sudo cp /vagrant/resources/hadoop/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml


# export path variables

echo "export HADOOP_LOG_DIR=/var/hadoop_logs" >> /home/vagrant/.bashrc

# Set Hadoop-related environment variables

echo "export HADOOP_HDFS_HOME=/usr/local/hadoop" >> /home/vagrant/.bashrc

echo "export JAVA_HOME=/usr/local/java" >> /home/vagrant/.bashrc
echo "export HADOOP_HOME=/usr/local/hadoop" >> /home/vagrant/.bashrc
echo "export HADOOP_HDFS_HOME=/usr/local/hadoop" >> /home/vagrant/.bashrc
echo "export HADOOP_MAPRED_HOME=/usr/local/hadoop" >> /home/vagrant/.bashrc
echo "export YARN_HOME=/usr/local/hadoop" >> /home/vagrant/.bashrc
echo "export HADOOP_COMMON_HOME=/usr/local/hadoop" >> /home/vagrant/.bashrc
#echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/hadoop/bin:/usr/local/hadoop/sbin" >> /home/vagrant/.bashrc
#echo "export PATH=$JAVA_HOME/bin:$PATH" >> /home/vagrant/.bashrc

echo "export PATH=/usr/local/java/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/hadoop/bin:/usr/local/hadoop/sbin" >> >> /home/vagrant/.bashrc

echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/hadoop/bin:/usr/local/hadoop/sbin" > /etc/environment
echo "JAVA_HOME=/usr/local/java" >> /etc/environment
source /etc/environment
source /home/vagrant/.bashrc

echo "export JAVA_HOME=/usr/local/java" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo "export HADOOP_LOG_DIR=/var/hadoop_logs" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo "export HDFS_NAMENODE_USER=\"vagrant\"" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo "export HDFS_DATANODE_USER=\"vagrant\"" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo "export HDFS_SECONDARYNAMENODE_USER=\"vagrant\"" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo "export YARN_RESOURCEMANAGER_USER=\"vagrant\"" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo "export YARN_NODEMANAGER_USER=\"vagrant\"" | sudo tee --append /usr/local/hadoop/etc/hadoop/hadoop-env.sh

##ssh key generation to start name node
sudo ssh-keygen -t rsa -P '' -f /home/vagrant/.ssh/id_rsa
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown vagrant /home/vagrant/.ssh/id_rsa
sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub
sudo chmod 400 /home/vagrant/.ssh/id_rsa

