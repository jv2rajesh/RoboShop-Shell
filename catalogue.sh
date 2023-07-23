echo -e  "\e[36m>>>>>>>> create catalogue service <<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e  "\e[36m>>>>>>>> create mongo repo <<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e  "\e[36m>>>>>>>> install nodejs repos <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e  "\e[36m>>>>>>>> Install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e  "\e[36m>>>>>>>> creating application user <<<<<<<<<<\e[0m"
useradd roboshop

echo -e  "\e[36m>>>>>>>> removing existing content in add directory <<<<<<<<<<\e[0m"
rm -rf /add

echo -e  "\e[36m>>>>>>>> creating directory <<<<<<<<<<\e[0m"
mkdir /app
echo -e  "\e[36m>>>>>>>> download application content <<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e  "\e[36m>>>>>>>> extracting application content <<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo -e  "\e[36m>>>>>>>> installing Nodejs dependencies <<<<<<<<<<\e[0m"
npm install

echo -e  "\e[36m>>>>>>>> installing mongodb client <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e  "\e[36m>>>>>>>> adding catalogue schema <<<<<<<<<<\e[0m"

mongo --host mongodb.jv2rajesh.online </app/schema/catalogue.js

echo -e  "\e[36m>>>>>>>> start catalogue service <<<<<<<<<<\e[0m"

systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
