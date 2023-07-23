echo ">>>>>>>> create catalogue service <<<<<<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service

echo ">>>>>>>> create mongo repo <<<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>>>> install nodejs repos <<<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>>> Install nodejs <<<<<<<<<<"
yum install nodejs -y

echo ">>>>>>>> creating application user <<<<<<<<<<"
useradd roboshop
echo ">>>>>>>> creating directory <<<<<<<<<<"
mkdir /app
echo ">>>>>>>> download application content <<<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>>> extracting application content <<<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo ">>>>>>>> installing Nodejs dependencies <<<<<<<<<<"
npm install

echo ">>>>>>>> installing mongodb client <<<<<<<<<<"
yum install mongodb-org-shell -y

echo ">>>>>>>> adding catalogue schema <<<<<<<<<<"

mongo --host mongodb.jv2rajesh.online </app/schema/catalogue.js

echo ">>>>>>>> start catalogue service <<<<<<<<<<"

systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
