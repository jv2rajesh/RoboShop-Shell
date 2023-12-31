echo -e "\e[36m>>>>>>>> Installing repo<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>>Enable Redis 6.2 from package streams <<<<<<<<\e[0m"
yum module enable redis:remi-6.2 -y &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>> Installing redis <<<<<<<<\e[0m"

yum install redis -y &>> /tmp/roboshop.log

sed -i 's/127.0.0.1/0.0.0.0/' etc/redis.conf /etc/redis/redis/conf
# Update listen address
systemctl enable redis &>> /tmp/roboshop.log
systemctl restart redis
# completed