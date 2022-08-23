svc data enable

am start -a android.intent.action.MAIN -e toasttext "切换蜂窝规则" -n bellavita.toast/.MainActivity


curl 'http://127.0.0.1:9090/proxies/%F0%9F%87%A8%F0%9F%87%B3%20%E5%A2%99%E5%86%85' \
  -X 'PUT' \
  -H 'Authorization: Bearer YourPassword' \
  --data-raw '{"name":"🆓🇨🇳 墙内免流"}' \
  --compressed
curl 'http://127.0.0.1:9090/proxies/%F0%9F%8C%91%20%E5%A2%99%E5%A4%96' \
  -X 'PUT' \
  -H 'Authorization: Bearer YourPassword' \
  --data-raw '{"name":"🆓🌑 墙外免流"}' \
  --compressed
curl 'http://127.0.0.1:9090/proxies/%F0%9F%87%A8%F0%9F%87%B3%20%E5%A2%99%E5%86%85%E5%8F%97%E9%99%90' \
  -X 'PUT' \
  -H 'Authorization: Bearer YourPassword' \
  --data-raw '{"name":"🆓🇨🇳 墙内受限免流"}' \
  --compressed
curl 'http://127.0.0.1:9090/proxies/%F0%9F%87%A8%F0%9F%87%B3%20%E5%A2%99%E5%86%85%20UDP' \
  -X 'PUT' \
  -H 'Authorization: Bearer YourPassword' \
  --data-raw '{"name":"🆓🇨🇳 墙内免流 UDP"}' \
  --compressed
curl 'http://127.0.0.1:9090/proxies/%F0%9F%8C%91%20%E5%A2%99%E5%A4%96%20UDP' \
  -X 'PUT' \
  -H 'Authorization: Bearer YourPassword' \
  --data-raw '{"name":"🆓🌑 墙外 UDP"}' \
  --compressed

curl 'http://127.0.0.1:9090/connections' \
  -X 'DELETE' \
    -H 'Authorization: Bearer YourPassword'

# sleep 1

# svc data disable

# sleep 1

# svc data enable