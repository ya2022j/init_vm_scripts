

systemctl restart firewalld;
sudo firewall-cmd --add-service=http --permanent;
sudo firewall-cmd --add-port=80/tcp --permanent; # nginx
sudo firewall-cmd --add-port=8001/tcp --permanent;
sudo firewall-cmd --add-port=8080/tcp --permanent; # vue gin 
sudo firewall-cmd --add-port=8000/tcp --permanent;
sudo firewall-cmd --add-port=443/tcp --permanent;
sudo firewall-cmd --add-port=8888/tcp --permanent; 

sudo firewall-cmd --add-port=5000/tcp --permanent; # flask
sudo firewall-cmd --add-port=27017/tcp --permanent; # mongodb
sudo firewall-cmd --add-port=3306/tcp --permanent; # mysql
sudo firewall-cmd --add-port=6379/tcp --permanent; # redis
sudo firewall-cmd --reload;
sudo firewall-cmd --list-ports;
