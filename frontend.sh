source common.sh

echo -e  "\e[36m>>>>>>>> Install nginx <<<<<<<<<<\e[0m"
yum install nginx -y &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>>>> Copy Roboshop configuration <<<<<<<<<<\e[0m"
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>>>> Deleting existing content <<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
func_exit_status

echo -e  "\e[36m>>>>>>>> Download application content <<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
func_exit_status

cd /usr/share/nginx/html
echo -e  "\e[36m>>>>>>>> Extracting application content <<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>>>> Start nginx service <<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx
func_exit_status
