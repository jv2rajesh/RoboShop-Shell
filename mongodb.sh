cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
# update listen file
systemctl enable mongod
systemctl restart mongod