SKIPUNZIP=1

status=""
architecture=""
system_gid="1000"
system_uid="1000"
clash_data_dir="/data/clash"
modules_dir="/data/adb/modules"
ca_path="/system/etc/security/cacerts"
CPFM_mode_dir="${modules_dir}/clash_premium"
mod_config="${clash_data_dir}/clash.config"
geoip_file_path="${clash_data_dir}/Country.mmdb"
apkPath="${clash_data_dir}/dashboard.apk"

if [ -d "${CPFM_mode_dir}" ] ; then
    touch ${CPFM_mode_dir}/remove && ui_print "- CPFM模块在重启后将会被删除."
fi

case "${ARCH}" in
    arm)
        architecture="armv7"
        ui_print "不支持的架构"
        exit 1
        ;;
    arm64)
        architecture="armv8"
        ;;
    x86)
        architecture="386"
        ui_print "不支持的架构"
        exit 1
        ;;
    x64)
        architecture="amd64"
        ui_print "不支持的架构"
        exit 1
        ;;
esac

mkdir -p ${MODPATH}/system/bin
mkdir -p ${clash_data_dir}
mkdir -p ${MODPATH}${ca_path}

unzip -o "${ZIPFILE}" -x 'META-INF/*' -d $MODPATH >&2

mv -f ${clash_data_dir} ${clash_data_dir}.old
mkdir ${clash_data_dir}
tar -xjf ${MODPATH}/binary/${ARCH}.tar.bz2 -C ${MODPATH}/system/bin/
mv ${MODPATH}/cacert.pem ${MODPATH}${ca_path}
mv -n ${MODPATH}/clash-dashboard ${clash_data_dir}/
rm -rf ${MODPATH}/clash-dashboard
mv -f ${MODPATH}/clash/* ${clash_data_dir}/
rm -rf ${MODPATH}/clash
rm -rf ${MODPATH}/binary

if [ ! -f "${clash_data_dir}/packages.list" ] ; then
    touch ${clash_data_dir}/packages.list
fi

sleep 1


ui_print "- 开始设置环境权限."
set_perm_recursive ${MODPATH} 0 0 0755 0644
set_perm  ${MODPATH}/system/bin/setcap  0  0  0755
set_perm  ${MODPATH}/system/bin/getcap  0  0  0755
set_perm  ${MODPATH}/system/bin/getpcaps  0  0  0755
set_perm  ${MODPATH}${ca_path}/cacert.pem 0 0 0644
set_perm  ${MODPATH}/system/bin/curl 0 0 0755
set_perm_recursive ${clash_data_dir} ${system_uid} ${system_gid} 0755 0644
set_perm_recursive ${clash_data_dir}/scripts ${system_uid} ${system_gid} 0755 0755
set_perm  ${MODPATH}/system/bin/clash  ${system_uid}  ${system_gid}  6755
set_perm  ${clash_data_dir}/clash.config ${system_uid} ${system_gid} 0755
set_perm  ${clash_data_dir}/packages.list ${system_uid} ${system_gid} 0644
#安装控制器
if [ "$(pm list packages | grep com.dashboard.kotlin)" ] || [ "$(pm list packages | grep -s com.dashboard.kotlin)" ];then
ui_print "- 无需安装DashBoard."
else
ui_print "- 开始安装DashBoard."
pm install -r --user 0 data/clash/备用/控制器.apk
ui_print "- ↑显示Success即为安装完成."
ui_print "- 如果失败请手动安装 安装包文件在:/data/clash/备用/控制器.apk"
fi
ui_print "- 模块安装已完成"
ui_print "- 请进入data/clash/config.yaml 指定位置填写订阅链接"
ui_print "- 建议打开 备用 文件夹仔细查看详细说明和配置模板"
ui_print "- 多看看教程，免得出问题一脸懵逼到处问"