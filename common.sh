log=/tmp/roboshop.log


func_apppreq() {

  echo -e  "\e[36m>>>>>>>> create ${component} service <<<<<<<<<<\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

  echo -e  "\e[36m>>>>>>>> creating application ${component} <<<<<<<<<<\e[0m"
  useradd roboshop &>>${log}

  echo -e  "\e[36m>>>>>>>> removing existing content in add directory <<<<<<<<<<\e[0m"
  rm -rf /app &>>${log}

  echo -e  "\e[36m>>>>>>>> creating directory <<<<<<<<<<\e[0m"
  mkdir /app &>>${log}
  echo -e  "\e[36m>>>>>>>> download application content <<<<<<<<<<\e[0m"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

  echo -e  "\e[36m>>>>>>>> extracting application content <<<<<<<<<<\e[0m"
  cd /app
  unzip /tmp/${component}.zip &>>${log}
  cd /app

}



func_systemd() {

  echo -e  "\e[36m>>>>>>>> start ${component} service <<<<<<<<<<\e[0m"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}

}



func_nodejs() {
log=/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>> create mongo repo <<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e  "\e[36m>>>>>>>> install nodejs repos <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e  "\e[36m>>>>>>>> Install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y &>>${log}

func_apppreq

echo -e  "\e[36m>>>>>>>> installing Nodejs dependencies <<<<<<<<<<\e[0m"
npm install &>>${log}

echo -e  "\e[36m>>>>>>>> installing mongodb client <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>${log}

echo -e  "\e[36m>>>>>>>> adding ${component} schema <<<<<<<<<<\e[0m"

mongo --host mongodb.jv2rajesh.online </app/schema/${component}.js &>>${log}

echo -e  "\e[36m>>>>>>>> start ${component} service <<<<<<<<<<\e[0m"

func_systemd

}




func_java() {

echo -e  "\e[36m>>>>>>>> install maven <<<<<<<<<<\e[0m"
yum install maven -y &>>${log}

func_apppreq

echo -e  "\e[36m>>>>>>>> install dependencies <<<<<<<<<<\e[0m"
mvn clean &>>${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}

echo -e  "\e[36m>>>>>>>> install mysql client <<<<<<<<<<\e[0m"
yum install mysql -y &>>${log}

echo -e  "\e[36m>>>>>>>>  load schema <<<<<<<<<<\e[0m"
mysql -h mysql.jv2rajesh.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}

func_systemd

}



func_python() {

  echo -e  "\e[36m>>>>>>>> Build ${component} service <<<<<<<<<<\e[0m"
  yum install python36 gcc python3-devel -y &>>${log}

  func_apppreq

  echo -e  "\e[36m>>>>>>>> Build ${component} service <<<<<<<<<<\e[0m"

  pip3.6 install -r requirements.txt &>>${log}

  func_systemd

}
