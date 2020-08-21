#!/bin/bash

SETSOURCE=$1;
BOTAUSERNAME=$2;
BOTAPASSWORD=$3;

BTFILE='/etc/init.d/bt';

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [ ! -f "$BTFILE" ]; then


	set -eux
	# install baota
	wget -O install.sh $SETSOURCE
	echo y | sh install.sh
	sed -i 's/set_panel_username()/set_panel_username(sys.argv[2])/' /www/server/panel/tools.py
  	# 清除登陆限制
	rm -f /www/server/panel/data/admin_path.pl
	# 修改面板username
	cd /www/server/panel && python tools.py username $BOTAUSERNAME
	# 修改面板密码
	cd /www/server/panel && python tools.py panel $BOTAPASSWORD

else

  echo "BOTA is install"

fi

/bin/bash
