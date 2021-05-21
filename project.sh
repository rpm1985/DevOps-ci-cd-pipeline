#!/bin/bash

# Terraform
# login as user centos, password authentication is via private key
# e.g. ssh -i cloud.key centos@<FLOATING_IP_ADDRESS>
# terraform runs cloud-init scripts as root user, remember to "cd root" on the VM before depositing any files on the machine
echo "updating terraform..."
sudo yum update

echo "cd to root directory..."
cd /root

echo "installing MySql..."
sudo yum install @mysql -y
sudo systemctl start mysqld
sudo systemctl enable --now mysqld
sudo systemctl status mysqld

echo "creating mysql_secure_installation.txt..."
touch mysql_secure_installation.txt
cat << `EOF` >> mysql_secure_installation.txt
y
2
Richmord1403_
Richmord1403_
y
y
y
y
y
`EOF`

echo "running mysql_secure_installation..."
mysql_secure_installation < mysql_secure_installation.txt

echo "installing java..."
sudo yum install java-11-openjdk-devel -y

echo "java version..."
which java
java --version

echo "javac version..."
which javac
javac --version

echo "installing unzip..."
sudo yum install unzip -y

echo "making /opt/gradle directory..."
sudo mkdir /opt/gradle

echo "installing gradle 5.4.1..."
cd /opt/gradle
sudo curl -sLo \
gradle-5.4.1-bin.zip \
https://services.gradle.org/distributions/gradle-5.4.1-bin.zip
sudo unzip gradle-5.4.1-bin.zip
sudo rm gradle-5.4.1-bin.zip
export GRADLE_HOME=/opt/gradle/gradle-5.4.1
export PATH=$GRADLE_HOME/bin:$PATH

echo "gradle version..."
which gradle
gradle --version

echo "creating /etc/profile.d/gradle.sh..."
sudo touch /etc/profile.d/gradle.sh
sudo chown vagrant.vagrant /etc/profile.d/gradle.sh
sudo cat << `EOF` >> /etc/profile.d/gradle.sh
export GRADLE_HOME=/opt/gradle/gradle-5.4.1 
export PATH=$GRADLE_HOME/bin:$PATH 
`EOF`
sudo chown root.root /etc/profile.d/gradle.sh
sudo chmod 644 /etc/profile.d/gradle.sh

echo "cd to root directory..."
cd /root

echo "installing git..."
sudo yum install git -y

echo "installing gitlab server key..."
touch .ssh/known_hosts
ssh-keyscan gitlab.cs.cf.ac.uk >> .ssh/known_hosts
chmod 644 .ssh/known_hosts

echo "installing gitlab deployment key..."
touch gitlab_team9.key
cat <<`EOF`>> gitlab_team9.key
-----BEGIN RSA PRIVATE KEY-----
MIIEoQIBAAKCAQEAzvpyvFxJZPeeul6Gp5Nh8B6QzqRu1Q4/dLGirW/y/xgv5jNO
qFUh6ByH6hsAdxRjPULbOJjIcnwKZ+fe56c+kvywQaa1NI71+nrct+muQk101875
ZZHdD2fd+uCK7OT4xSjsw96TBvBE6a84jLm0+CLzM6491aodo/oum8D+aXzKTPVL
6KA96stjohAcPgDUGERahZgXHnVoNpbUg2OyvY72/sr2Z2jh4QwqxUZrOsPq8WKG
k4NrO+h3x6PDAONUNDHD7FtXr8bRHS9VvD3hQ9VF+o2Pp20mFmq1FjRGy5WAzvGv
7h8Dcd90FfJi1sfTdVay4xCUAhcNqUYdZnoA6QIDAQABAoIBAARxjgsLNCwtwMOh
ieSJHn4oOdWl5BdA4g3gTmzIzX+6hjS7/0FP6pVwH17gS4dC8cp75/b0GMGUdii6
6qcwiQBg2mveZ1+EfjVtc9Wi97HGte54LBSJKCTPhw1+ypzBYbHh6gteeOuaNvCJ
aX5j8kWtgmkmoX830sEVevCvGQcss8JRmU/8iX3cf58uixK8l3UKUH8OU+WL4LT1
WMMKq6qWKjRneet4suD43cURFgcaODsN0kB+lr4NsWwhUelJ7uSx9AbqxWBdl84A
pfwoJKfSk4/QIplcvPkzl3V/irD/m2/pJpQz82cVfCl6qgjUfyCuhNKeQnk9xHBG
3Wg4qwECgYEA/Ddb7y3bzIj6hAWh3lU2fVf6lr9BpQRiUcO4/ztell7qeiLeYVHj
DdTZrQKsC8SAxIbT7IBsN6dKRpy/V1QPwNaRceCZCgGWIHQ5+o0wFNIKPw/Rt11h
vroufe2POTv/aswhHw6+R01zO9O/fn6irHRANlKDe5JN/aDjVca9FkkCgYEA0hVa
HJPbpSokTKfdAFw0vioKiAdTLeT8qX30oKC7SxVZMxEcYCWaga9zT71aT2qSmbia
X24X4txoblWDzIrUolphDahFQI4sStfRg8skNlgYpgzQJePpIvWDmcIGuWcjvmZq
OO15MAlVP+gqnGKZ+GStaUDX2/Bg3XF/CgTjFaECgYA0eEfV8FJjsLN9N7a/DDcz
yFPHfK5paAoUPIWGA5Hf8osRMaPV1zVHMVq/lWi5Yf3v5KS99NGOmmznV8CuqDxG
v9yuNi1gWYgj5EoTh7/S9QdQqzfTz8d/6De31u4O2B6A10qkrWqEZuZsMdcKt8mb
2uto4a2czYkQFKJ2u8umkQJ/OxXGQkNTgyBXFTgg7/j+3Hz2eUuWGVJNvV2vb33F
L1jRvYsSb/gjfFXcGJEo1S0kDhfdUvmjvio/NMjYSK7DHuZMZYrt7zoNOv937Zk0
lhQw2oLAB+gRqcNjP9tSCNL5OpOTTG99pgT59P9W/KS+qR2np/KUw0bX92/0St0V
AQKBgQC91xIrT9R1wSjfl/vnKkk5G2pAiB3uQ9crHDO/qSf9MF6fgQNob+SLxhdn
HO+aBSoIIYYFvI+IzxUzf5aOh53tesbf93eMuC1EvR7MrJyhwSpiG2WrgSP1uLEr
l6ZD9B1XBBdXaazbUR+jF6P2ld3JmYDHcxx6xkgmBSuiIf/1zw==
-----END RSA PRIVATE KEY-----
`EOF`
chmod 400 gitlab_team9.key

echo "cloning repository..."
ssh-agent bash -c 'ssh-add gitlab_team9.key; git clone git@gitlab.cs.cf.ac.uk:c1855378/team-9-admiral-client-project.git'

echo "changing to repository directory..."
cd team-9-admiral-client-project/time-sheet-manager/src/main/resources

echo "adding database schema..."
mysql -u root -p'Richmord1403_' < Schema.sql

echo "adding database data..."
mysql -u root -p'Richmord1403_' < data.sql

echo "changing directory..."
cd ../../..

echo "building project..."
gradle assemble


echo "Changing directory..."
cd build/libs

echo "running proect..."
java -jar -Dserver.port=8081 time-sheet-manager-0.0.1-SNAPSHOT.jar
