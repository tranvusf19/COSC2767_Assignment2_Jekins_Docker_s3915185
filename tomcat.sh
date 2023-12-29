#!/bin/bash
sudo amazon-linux-extras install java-openjdk11

cat > /root/tomcatScript.sh << EOF
#!/bin/bash
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.83/bin/apache-tomcat-9.0.83.tar.gz
tar -xvzf apache-tomcat-9.0.83.tar.gz
mv apache-tomcat-9.0.83 tomcat	
rm -rf "apache-tomcat-9.0.83.tar.gz"

sed -i '21s/^/<!-- /' "/opt/tomcat/webapps/host-manager/META-INF/context.xml"
sed -i '22s/$/ -->/' "/opt/tomcat/webapps/host-manager/META-INF/context.xml"
sed -i '21s/^/<!-- /' "/opt/tomcat/webapps/manager/META-INF/context.xml"
sed -i '22s/$/ -->/' "/opt/tomcat/webapps/manager/META-INF/context.xml"
sed -i "55a\\<role rolename=\"admin-gui,manager-gui,manager,admin\"/>" "/opt/tomcat/conf/tomcat-users.xml"
sed -i '56a\\<role rolename="admin-gui"/>' "/opt/tomcat/conf/tomcat-users.xml"
sed -i '57a\\<role rolename="manager-gui"/>' "/opt/tomcat/conf/tomcat-users.xml"
sed -i '58a\\<role rolename="manager-script"/>' "/opt/tomcat/conf/tomcat-users.xml"
sed -i '59a\\<role rolename="manager-jmx"/>' "/opt/tomcat/conf/tomcat-users.xml"
sed -i '60a\\<role rolename="manager-status"/>' "/opt/tomcat/conf/tomcat-users.xml"
sed -i '61a\\<user username="admin" password="s3cret" roles="admin-gui,manager-gui, manager-script,manager-jmx, manager-status"/>' "/opt/tomcat/conf/tomcat-users.xml"

cd ~
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

tomcatdown
tomcatup

EOF