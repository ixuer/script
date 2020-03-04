#!/bin/bash -v

set -x

echo '#######################################################################'
echo "shadowsocks安装程序已启动..."


# 安装git
echo "正在安装git......"
yum install -y git
if [ "$?" == 0 ]
then
	echo "git安装成功！"
	echo "正在安装docker"
	yum install -y docker
	if [ "$?" == 0 ]
	then 
		echo "docker安装成功，正在启动docker服务..."
		systemctl start docker
		read -p "请输入docker容器暴露的端口(默认9999)：" port_1
			if [ -n ${port_1} ]
			then 
				port_1=9999
				echo "使用默认端口号:9999"
			fi
		read -p "请输入shadowsocks的密码(默认qwerty)：" password
			if [ -n ${password} ]
			then 
				password=qwerty
				echo "使用默认密码:qwerty"
			fi
		echo "可选加密方式：aes-128-cfb | aes-256-cfb | aes-128-gcm | aes-256-gcm | chacha20"
		read -p "请选择加密方式(默认aes-256-cfb)：" type;
			if [ -n ${type} ]
			then 
				type=aes-256-cfb
				echo "使用默认加密方式:aes-256-cfb"
			fi
		echo "您输入的端口是：${port_1}"
		echo "您输入的密码是：${password}"
		echo "您选择的加密方式是：${type}"
		echo "正在启动docker容器..."
		
		
		echo `docker run -d -p ${port_1}:${port_1} oddrationale/docker-shadowsocks -s 0.0.0.0 -p ${port_1} -k ${password} -m ${type}`
		
		echo "容器启动完成！！！"
		echo "端口号：${port_1}"
		echo "密码：${password}"
		echo "加密方式：${type}"

	else
		echo "docker安装失败，请尝试重新运行该脚本"
	fi
	
else 
	echo "git安装失败，请尝试重新运行该脚本"
fi
echo '#######################################################################'
