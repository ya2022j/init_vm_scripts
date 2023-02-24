# 1.ssh-keygen
# 2. install zsh tmux docker docker-compose  
# 3. 专门使用 docker安装的mysql，mongodb，nginx 



#   # 1. client (windows or linux )
# ssh-keygen -t rsa -b 4096

# # 用cat命令查看是否生成产生公钥私钥对

# ls -Rl /root/.ssh
# #- id_rsa---->private key
# #- id_rsa.pub---->public key

# #第二步:用ssh-copy-id将公钥复制到远程机器中 (from client)
#  ssh-copy-id -i /root/.ssh/id_rsa.pub  root@serverIP
#  # 注意: ssh-copy-id 将key写到远程机器的 ~/ .ssh/authorized_key.文件中

#  # 这里假定服务器还可以使用密码登录。当时添加公钥之后，就要修改ssh服务的配置文件。取消密码登录，只能用证书登陆
#  # 并重启ssh服务
#  vim /etc/ssh/sshd_config
#  PasswordAuthentication no
# RSAAuthentication yes
# PubkeyAuthentication yes
# service sshd restart

# # 第三步: 登录到远程机器不用输入密码

# # client : linux
# ssh root@serverIP

# # client : windows
# ssh -i id_rsa root@serverIP

clear
echo
echo "#############################################################"
echo "#install zsh                                                #"
echo

# https://blog.csdn.net/qierkang/article/details/85941316
 echo $SHELL;
 cat /etc/shells ;
 yum -y install zsh;
 chsh -s /bin/zsh;
 yum install -y wget git ;
 wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh;


cd ~/.oh-my-zsh/plugins;
wget http://mimosa-pudica.net/src/incr-0.2.zsh;
source incr*.zsh;


cd ~/.oh-my-zsh/plugins;
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;

sed -i 's\robbyrussell\cypher\g' ~/.zshrc;
sed -i 's\(git)\(git history history-substring-search node npm wd web-search last-working-dir zsh-autosuggestions)\g' ~/.zshrc;
source ~/.zshrc;
# vim ~/.zshrc

clear
echo
echo "#############################################################"
echo "#install tmux                                               #"
echo
 

 yum install tmux -y;


clear
echo
echo "#############################################################"
echo "#install docker                                            #"
echo
 

uname -r;
yum -y update;
yum remove docker  docker-common docker-selinux docker-engine;
yum install -y yum-utils device-mapper-persistent-data lvm2;

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo;


yum list docker-ce --showduplicates | sort -r;
yum -y install docker-ce-18.03.1.ce;
systemctl start docker;
systemctl enable docker;
docker  version;






clear
echo
echo "#############################################################"
echo "#install python3                                            #"
echo
 



#卸载python3
rpm -qa|grep python3|xargs rpm -ev --allmatches --nodeps ;

#删除所有残余文件
whereis python3 |xargs rm -frv;

#查看现有安装的python，验证是否删除干净
whereis python ;




wget https://www.openssl.org/source/openssl-1.1.1a.tar.gz;
tar -zxvf openssl-1.1.1a.tar.gz;
cd openssl-1.1.1a;

./config --prefix=/usr/local/openssl no-zlib;
make  && make install;



ln -s /usr/local/openssl/include/openssl /usr/include/openssl;
ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/local/lib64/libssl.so;
ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl;

echo "/usr/local/openssl/lib" >> /etc/ld.so.conf;

ldconfig -v;
openssl version;



yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make libffi-devel;
yum install wget;
wget https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tgz;
tar -zxvf Python-3.8.1.tgz;
cd Python-3.8.1;
# 配置安装位置
./configure --prefix=/usr/local/python3 --with-openssl=/usr/local/openssl;
# 安装之后要修改yum 的配置

#
#配置yum
#安装python3改完软链接以后发现yum命令报错了，yum是依赖python2.7的，你把python改成了3.8了，所以报错了。
#
#可以修改yum里对python2的依赖即可。虽然安装了python3但是系统里python2依旧还在系统里，可以通过python2来指定用python2.7的命令，首先来看下python2的命令在哪里
#
#[root@localhost ~]# which python2
#/usr/bin/python2
#1
#2
#可以cd到/usr/bin目录下 通过ls -alh|grep python查看python命令的详细情况。
#
#[root@localhost bin]# ls -alh|grep python
#1
#
#可以看到python软连接是执行的python3命令，python2是执行的python2.7的命令
#
#vi /usr/libexec/urlgrabber-ext-down
#1
#修改对python的依赖，修改成python2或python2.7都可以。
#
#
#vi /usr/bin/yum


# WARNING: Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/pip/
## 以上问题的对策，换镜像 ，豆瓣的

# 安装
make && make install;

 cd /usr/local/;


 #添加python3的软链接
ln -s /usr/local/python3/bin/python3.8 /usr/bin/python3 ;

#添加 pip3 的软链接
ln -s /usr/local/python3/bin/pip3.8 /usr/bin/pip3;

pip3  install --upgrade pip -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
pip3  install docker-compose -i http://pypi.douban.com/simple --trusted-host pypi.douban.com




clear
echo
echo "#############################################################"
echo "#install docker-compose                                     #"
echo
 



#安装docker-compose(已安装者忽略)
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
sudo chmod  +x /usr/local/bin/docker-compose;
#查询是否安装成功

docker-compose -v ;



clear
echo
echo "#############################################################"
echo "#install node npm vue-cli yarn                              #"
echo
 
 wget https://nodejs.org/dist/v16.15.0/node-v16.15.0-linux-x64.tar.xz;
tar -xvf node-v16.15.0-linux-x64.tar.xz;
mv node-v16.15.0-linux-x64   /usr/local/nodejs
mv node-v16.15.0-linux-64/ nodejs;
ln -s /usr/local/nodejs/bin/npm /usr/local/bin/;
ln -s /usr/local/nodejs/bin/node /usr/local/bin/;
node -v;
npm -v;

# install vue-cli 
 npm config set registry https://registry.npm.taobao.org;
  npm config get registry;
   npm install -g @vue/cli;
    ln -s /opt/nodejs/bin/vue /usr/bin/vue;
     echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc;
     source ~/.zshrc;
      npm config set prefix /usr/local;
       npm install -g @vue/cli;
         vue -V;
 
npm install -g vue-cli yarn;




clear
echo
echo "#############################################################"
echo "#install golang                                             #"
echo
 
wget  https://go.dev/dl/go1.19.3.linux-amd64.tar.gz;
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz;
export PATH=$PATH:/usr/local/go/bin;
go version;
