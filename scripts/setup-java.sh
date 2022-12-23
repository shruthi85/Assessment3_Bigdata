#!/bin/bash
source "/vagrant/scripts/common.sh"

sudo ssh-keygen -t rsa -P '' -f /home/vagrant/.ssh/id_rsa
cat /home/vagrant/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sudo chown vagrant /home/vagrant/.ssh/id_rsa
sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub
sudo chmod 400 /home/vagrant/.ssh/id_rsa

function installLocalJava {
	FILE=/vagrant/resources/$JAVA_ARCHIVE
	tar -xzf $FILE -C /usr/local
}
function setupJava {
	echo "setting up java"
	ln -s /usr/local/jdk-17.0.5  /usr/local/java
	ln -s /usr/local/java/bin/java /usr/bin/java
	ln -s /usr/local/java/bin/javac /usr/bin/javac
	ln -s /usr/local/java/bin/jar /usr/bin/jar
	ln -s /usr/local/java/bin/javah /usr/bin/javah
}

function setupEnvVars {
	echo "creating java environment variables"
	echo export JAVA_HOME=/usr/local/java >> /etc/profile.d/java.sh
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> /etc/profile.d/java.sh
	chmod +x /etc/profile.d/java.sh
}

function installJava {
		echo "installing open jdk from local file"
	    installLocalJava
}

echo "setup java"
installJava
setupJava
setupEnvVars