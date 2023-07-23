echo -e "\e[36m>>>>>>>> Installing repo<<<<<<<<\e[om"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[36m>>>>>>>>Enable Redis 6.2 from package streams <<<<<<<<\e[om"
yum module enable redis:remi-6.2 -y

echo -e "\e[36m>>>>>>>> Installing redis <<<<<<<<\e[om"
yum install redis -y
# Update listen address
systemctl enable redis
systemctl restart redis