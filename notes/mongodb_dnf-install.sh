# this MUST be done before installing the main package
sudo dnf install mongodb-mongosh-shared-openssl3


sudo echo -e "\
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9Server/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc" \
    >> '/etc/yum.repos.d/mongodb-org-7.0.repo'

# this is here partly to stop mongoDB collecting data on me, but mostly to
# stop SELinux shouting at me
sudo echo -e "\
setParameter:
  diagnosticDataCollectionEnabled: false"
    >> '/etc/mongod.conf'

sudo dnf install mongodb-org

# should be enabled automatically
# sudo systemctl enable mongod.service
sudo systemctl start mongod.service

# now test everyhting's worked by running `mongosh`
# if you get an openSSL config error, you maybe didn't install 
# `mongodb-mongosh-shared-openssl3` before `mongodb-org`
