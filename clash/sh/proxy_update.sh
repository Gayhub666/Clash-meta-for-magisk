res=`dumpsys netstats | grep -E 'iface=wlan.*networkId'`

echo $res

if [ -z "${res}" ]; then
    echo '未连接wifi'

    sh /data/sh/proxy_cellular.sh
else
    echo '连接wifi'

    sh /data/sh/proxy_wifi.sh
fi


