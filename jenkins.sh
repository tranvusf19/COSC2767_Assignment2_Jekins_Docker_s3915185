#!/bin/bash
#pull jenkins repo and import
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

#install java-openjdk
sudo amazon-linux-extras install java-openjdk11 -y

#install jenkins and git
yum install jenkins -y
yum install git -y

#start jenkins service, and copy jenkins password for better accessing
service jenkins start
mkdir /root/password
echo $(cat /var/lib/jenkins/secrets/initialAdminPassword) >> /root/password/cred

#create mavenScript to install maven
cat > /root/mavenScript.sh << EOF
#!/bin/bash
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
tar -xvzf apache-maven-3.9.5-bin.tar.gz
mv apache-maven-3.9.5 maven
rm -rf "apache-maven-3.9.5-bin.tar.gz"

#setup bash file for PATH
cd ~
sed -i '9a\\M2_HOME=/opt/maven' ".bash_profile"
sed -i '10a\\M2=/opt/maven/bin' ".bash_profile"
sed -i '11a\\JAVA_HOME=/usr/lib/bin/jvm/java-11-openjdk-11.0.20.0.8-1.amzn2.0.1.x86_64' ".bash_profile"
sed -i '13s/$/:\$JAVA_HOME:\$M2_HOME:\$M2/' ".bash_profile"
source ~/.bash_profile
echo "Finished bashing Maven"
echo "If mvn -v doesn't work, try source .bash_profile"
echo "--------------------------------------"
EOF