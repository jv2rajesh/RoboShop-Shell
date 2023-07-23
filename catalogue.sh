
cp catalogue.service /etc/systemd/system/catalogue.service
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install nodejs -y
rm -rf /tmp/catalogue.zip
useradd roboshop
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install

yum install mongodb-org-shell -y

mongo --host mongodb.jv2rajesh.online </app/schema/catalogue.js
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
