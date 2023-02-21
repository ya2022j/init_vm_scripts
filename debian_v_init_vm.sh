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
sudo apt install  -y  zsh;
 chsh -s /bin/zsh;
sudo apt install -y wget git ;
 wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh;


cd ~/.oh-my-zsh/plugins;
wget http://mimosa-pudica.net/src/incr-0.2.zsh;
source incr*.zsh;


cd ~/.oh-my-zsh/plugins;
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;

sed -i 's\robbyrussell\cypher\g' ~/.zshrc;
sed -i 's\(git)\(git history history-substring-search node npm wd web-search last-working-dir zsh-autosuggestions)\g' ~/.zshrc;
source ~/.zshrc;



clear
echo
echo "#############################################################"
echo "#install tmux                                               #"
echo
 

sudo apt-get  install tmux -y


clear
echo
echo "#############################################################"
echo "#install docker                                            #"
echo
 







clear
echo
echo "#############################################################"
echo "#install python3                                            #"
echo
 





#卸载python3
sudo apt-get remove python3 ;
# #删除所有残余文件
sudo apt-get remove --auto-remove python3 ;
sudo apt-get purge --auto-remove python3 ;
rm -rf /usr/bin/python3;
rm -rf /usr/bin/pip3;


# #查看现有安装的python，验证是否删除干净
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


# 安装
make && make install;

 cd /usr/local/;


 #添加python3的软链接
ln -s /usr/local/python3/bin/python3.8 /usr/bin/python3 ;

#添加 pip3 的软链接
ln -s /usr/local/python3/bin/pip3.8 /usr/bin/pip3;


pip3  install --upgrade pip -i http://pypi.douban.com/simple --trusted-host pypi.douban.com;
pip3  install docker-compose -i http://pypi.douban.com/simple --trusted-host pypi.douban.com;
