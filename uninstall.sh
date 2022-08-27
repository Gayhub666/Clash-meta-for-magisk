Clash_data_dir="/data/clash"
Clash_old="/data/clash.old"
rm_data() {
    rm -rf ${Clash_data_dir}
    rm -rf ${Clash_old}
}

rm_data