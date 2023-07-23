echo -e  "\e[36m>>>>>>>> create catalogue service <<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> create mongo repo <<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> install nodejs repos <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> Install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> creating application user <<<<<<<<<<\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> removing existing content in add directory <<<<<<<<<<\e[0m"
rm -rf /app &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> creating directory <<<<<<<<<<\e[0m"
mkdir /app &>>/tmp/roboshop.log &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>>> download application content <<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> extracting application content <<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e  "\e[36m>>>>>>>> installing Nodejs dependencies <<<<<<<<<<\e[0m"
npm install &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> installing mongodb client <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> adding catalogue schema <<<<<<<<<<\e[0m"

mongo --host mongodb.jv2rajesh.online </app/schema/catalogue.js &>>/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> start catalogue service <<<<<<<<<<\e[0m"


systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
