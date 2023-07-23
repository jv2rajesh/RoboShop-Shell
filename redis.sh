echo ">>>>>>>>> Installing repo<<<<<<<<<"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo ">>>>>>>>>Enable Redis 6.2 from package streams <<<<<<<<<"
yum module enable redis:remi-6.2 -y

echo ">>>>>>>>> Installing redis <<<<<<<<<"
yum install redis -y
# Update listen address
systemctl enable redis
systemctl restart redis