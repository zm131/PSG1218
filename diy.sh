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



# Modify the version number
sed -i 's/OpenWrt/Leopard build $(date "+%Y.%m.%d") @ OpenWrt/g' package/default-settings/files/zzz-default-settings

# 添加新的主题包
# git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/lean/luci-theme-opentomcat

# 去除默认主题
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 添加clash支持
# git clone https://github.com/frainzy1477/luci-app-clash.git package/lean/luci-app-clash

# 添加v2ray
# git clone https://github.com/kuoruan/luci-app-v2ray.git package/lean/luci-app-v2ray
# rm rm -rf package/lean/v2ray
# git clone https://github.com/KFERMercer/openwrt-v2ray.git package/lean/v2ray
# git clone https://github.com/frainzy1477/luci-app-clash.git package/lean/luci-app-clash




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
git clone $wifischedule_url package/lean/luci-app-wifischedule
echo 'CONFIG_PACKAGE_luci-app-wifischedule=y' >> .config
