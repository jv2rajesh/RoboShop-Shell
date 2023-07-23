
log=/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> create user service <<<<<<<<<<\e[0m"
cp user.service /etc/systemd/system/user.service &>>${log}

echo -e  "\e[36m>>>>>>>> create mongo repo <<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e  "\e[36m>>>>>>>> install nodejs repos <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e  "\e[36m>>>>>>>> Install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y &>>${log}

echo -e  "\e[36m>>>>>>>> creating application user <<<<<<<<<<\e[0m"
useradd roboshop &>>${log}

echo -e  "\e[36m>>>>>>>> removing existing content in add directory <<<<<<<<<<\e[0m"
rm -rf /app &>>${log}

echo -e  "\e[36m>>>>>>>> creating directory <<<<<<<<<<\e[0m"
mkdir /app &>>${log} &>>${log}
echo -e  "\e[36m>>>>>>>> download application content <<<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log}

echo -e  "\e[36m>>>>>>>> extracting application content <<<<<<<<<<\e[0m"
cd /app
unzip /tmp/user.zip &>>${log}
cd /app

echo -e  "\e[36m>>>>>>>> installing Nodejs dependencies <<<<<<<<<<\e[0m"
npm install &>>${log}

echo -e  "\e[36m>>>>>>>> installing mongodb client <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>${log}

echo -e  "\e[36m>>>>>>>> adding user schema <<<<<<<<<<\e[0m"

mongo --host mongodb.jv2rajesh.online </app/schema/user.js &>>${log}

echo -e  "\e[36m>>>>>>>> start user service <<<<<<<<<<\e[0m"


systemctl daemon-reload
systemctl enable user
systemctl restart user

