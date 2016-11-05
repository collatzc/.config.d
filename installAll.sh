#! /bin/bash
_VERSION='0.0.1'
OPT_INSTALL=(1 1 1 1 1 1 1 1 1 1)

function install() {
  i=0
  while [ "$i" -le "9" ]; do
    if [ "${OPT_INSTALL[$i]}" -eq "1" ]; then
      case $i in
        0)
          echo
          echo "Updating datetime..."
          ntpdate time.apple.com
          ;;
        1)
          echo
          echo 'Configging shell & vim...'
          cp ./.config.d/.vimrc ~/.vimrc
          ./installVundle.sh
          vim +PluginInstall +qall
          yum install -y tmux
          ;;
        2)
          echo
          echo 'Installing epel-release...'
          yum install -y epel-release
          ;;
        3)
          echo
          echo 'Installing nginx...'
          #wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
          echo "[nginx]" >> /etc/yum.repos.d/nginx.repo
          echo "name=nginx repo" >> /etc/yum.repos.d/nginx.repo
          echo "baseurl=http://nginx.org/packages/centos/7/\$basearch/" >> /etc/yum.repos.d/nginx.repo
          #echo "baseurl=http://nginx.org/packages/centos/5/\$basearch/" >> /etc/yum.repos.d/nginx.repo
          echo "gpgcheck=0" >> /etc/yum.repos.d/nginx.repo
          echo "enabled=1" >> /etc/yum.repos.d/nginx.repo
          yum -y install nginx
          systemctl start nginx.service
          systemctl enable nginx.service
          firewall-cmd --permanent --zone=public --add-service=http
          firewall-cmd --permanent --zone=public --add-service=https
          ;;
        4)
          echo
          echo "Installing MongoDB 3.2 ..."
          echo "[mongodb-org-3.2]" >> /etc/yum.repos.d/mongodb-org-3.2.repo
          echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-org-3.2.repo
          echo "baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/" >> /etc/yum.repos.d/mongodb-org-3.2.repo
          echo "enabled=1" >> /etc/yum.repos.d/mongodb-org-3.2.repo
          echo "gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc" >> /etc/yum.repos.d/mongodb-org-3.2.repo
          yum install -y mongodb-org
          ;;
        5)
          echo
          echo "Installing MariaDB 10.1 ..."
          echo "# MariaDB 10.1 CentOS repository list - created 2015-11-02 17:35 UTC" >> /etc/yum.repos.d/MariaDB.repo
          echo "# http://mariadb.org/mariadb/repositories/" >> /etc/yum.repos.d/MariaDB.repo
          echo "[mariadb]" >> /etc/yum.repos.d/MariaDB.repo
          echo "name = MariaDB" >> /etc/yum.repos.d/MariaDB.repo
          echo "baseurl = http://yum.mariadb.org/10.1/centos7-amd64" >> /etc/yum.repos.d/MariaDB.repo
          echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
          echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo
          yum -y install MariaDB-server MariaDB-client
          firewall-cmd --permanent --zone=public --add-port=3306/tcp
          cat <<EOM > "/etc/my.cnf"
[client]
port = 3306
socket = /var/lib/mysql/mysql.sock
default-character-set = utf8
[mysqld]
port = 3306
socket = /var/lib/mysql/mysql.sock
skip-external-locking
key_buffer_size = 384M
max_allowed_packet = 1M
table_open_cache = 512
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
myisam_sort_buffer_size = 64M
thread_cache_size = 8
query_cache_size = 32M
bind-address = 0.0.0.0
thread_concurrency = 8

skip-character-set-client-handshake
collation_server = utf8_unicode_ci
init-connect='SET NAMES utf8'
character_set_server = utf8
log-bin=mysql-bin

server-id = 1

[mysqldump]
quick
max_allowed_packet = 16M
default-character-set=utf8
[mysql]
no-auto-rehash
default-character-set = utf8
[myisamchk]
key_buffer_size = 256M
sort_buffer_size = 256M
read_buffer = 2M
write_buffer = 2M
[mysqlhotcopy]
interactive-timeout
EOM

          systemctl start mysql
          mysql_secure_installation
          ;;
        6)
          echo
          echo '6. Installing redis...'
          wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/7/x86_64/e/
          rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-*.rpm
          #wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/5/i386/e/
          #rpm -Uvh dl.fedoraproject.org/pub/epel/5/i386/e/epel-release-*.rpm
          yum -y install redis
          systemctl start redis.service
          systemctl enable redis.service
          ;;
        7)
          echo
          echo '7. Installing php-fpm & php...'
          yum -y install php php-mysqlnd php-fpm php-redis php-soap php-curl php-gd php-mbstring php-bcmath
          sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g; s/;listen.owner = nobody/listen.owner = nginx/g; s/;listen.group = nobody/listen.group = nginx/g; s/user = apache/user = nginx/g; s/group = apache/group = nginx/g; s/php_value\[session.save_handler\] = files/php_value\[session.save_handler\] = redis/g; s/php_value\
            [session.save_path\] = \/var\/lib\/php\/session/php_value\[session.save_path\] = "tcp:\/\/127.0.0.1:6379"/g' /etc/php-fpm.d/www.conf
          sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g; s/;date.timezone =/date.timezone = Europe\/Berlin/g' /etc/php.ini

          systemctl start php-fpm.service
          systemctl enable php-fpm.service
          systemctl restart nginx.service
          ;;
        8)
          echo
          echo '8. Creating user nginx & config...'
          sed -i 's/nginx:x:\([0-9]*\):\([0-9]*\):nginx user:\/var\/cache\/nginx:\/sbin\/nologin/nginx:x:\1:\2:nginx user:\/usr\/share\/nginx:\/bin\/bash/g' /etc/passwd
          usermod -g wheel nginx
          #sed -i 's/%wheel\tALL=(ALL)\tALL/%wheel\tALL=(ALL)\tNOPASSWD: ALL/' /etc/sudoers
          passwd nginx
          chown -R nginx:nginx /usr/share/nginx
          ;;
        9)
          echo
          echo '9. Configging SeLinux...'
          setsebool -P httpd_can_network_connect=1
          ;;
      esac
    fi
    let i=i+1
  done
  echo
  echo 'Cleaning up...'
  yum clean all
  firewall-cmd --reload
  echo
  echo 'Done!'
}

function list() {
  echo "--- List of Installation ---"
  if [ "${OPT_INSTALL[0]}" -eq "1" ]; then
    echo "[x] 0. Do update datetime"
  else
    echo "[ ] 0. Don't update datetime"
  fi
  if [ "${OPT_INSTALL[1]}" -eq "1" ]; then
    echo "[x] 1. Do config shell & vim"
  else
    echo "[ ] 1. Don't config shell & vim"
  fi
  if [ "${OPT_INSTALL[2]}" -eq "1" ]; then
    echo "[x] 2. Do install epel-release"
  else
    echo "[ ] 2. Don't install epel-release"
  fi
  if [ "${OPT_INSTALL[3]}" -eq "1" ]; then
    echo "[x] 3. Do install nginx"
  else
    echo "[ ] 3. Don't install nginx"
  fi
  if [ "${OPT_INSTALL[4]}" -eq "1" ]; then
    echo "[x] 4. Do install MongoDB 3.2"
  else
    echo "[ ] 4. Don't install MongoDB 3.2"
  fi
  if [ "${OPT_INSTALL[5]}" -eq "1" ]; then
    echo "[x] 5. Do install MariaDB 10.1"
  else
    echo "[ ] 5. Don't install MariaDB 10.1"
  fi
  if [ "${OPT_INSTALL[6]}" -eq "1" ]; then
    echo "[x] 6. Do install redis"
  else
    echo "[ ] 6. Don't install redis"
  fi
  if [ "${OPT_INSTALL[7]}" -eq "1" ]; then
    echo "[x] 7. Do install php-fpm & php"
  else
    echo "[ ] 7. Don't install php-fpm & php"
  fi
  if [ "${OPT_INSTALL[8]}" -eq "1" ]; then
    echo "[x] 8. Do create user nginx & config"
  else
    echo "[ ] 8. Don't create user nginx & config"
  fi
  if [ "${OPT_INSTALL[9]}" -eq "1" ]; then
    echo "[x] 9. Do config SeLinux"
  else
    echo "[ ] 9. Don't config SeLinux"
  fi
  echo "END 0. Clean up"
  echo "--- End of List ---"

  read -p "Input number<0-9> to change; <enter> to execute;<#> to quit:" opt
  if [ -z "$opt" ]; then
    echo "Begin to install..."
    echo
    install
  else
    if [ "$opt" = "#" ]; then
      echo "Bye"
      exit
    elif [ "$opt" -ge "0" -a "$opt" -le "9" 2> /dev/null ]; then
      if [ "${OPT_INSTALL[$opt]}" -eq "1" ];  then
        OPT_INSTALL[$opt]=0
      else
        OPT_INSTALL[$opt]=1
      fi
      clear
      list
    else
      echo "ERROR: Not an option."
      list
    fi
  fi
}

echo "Install All on CentOS 7"
echo "v"$_VERSION
echo
list

