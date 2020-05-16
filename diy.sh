#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP




device_name='PSG1218'
wifi_name='PHICOMM'
lan_ip='192.168.2.1'        # Lan Ip地址
utc_name='Asia\/Shanghai'   # 时区

wifischedule_url='https://github.com/newkit/luci-app-wifischedule.git' # wifi计划插件地址

 
 



#修改机器名称
echo "设置主机名"
sed -i "s/OpenWrt/$device_name/g" package/base-files/files/bin/config_generate


sed -i 's/192.168.1.1/$lan_ip/g' package/base-files/files/bin/config_generate

#修改默认时区
echo "修改时区"
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='$utc_name'/g" package/base-files/files/bin/config_generate


echo "修改wifi名称"

sed -i "s/OpenWrt/$wifi_name/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh


echo '添加wifi计划插件'
git clone $wifischedule_url package/luci-app-wifischedule
echo 'CONFIG_PACKAGE_luci-app-wifischedule=y' >> .config

 
