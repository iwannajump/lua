#Simple Vk bot written in Lua

dependencies: `luasec` and `luasocket`

# How to install?

```
sudo luarocks install luasec
```
```
sudo luarocks install luasocket
```

# How to start using this bot?

First of all, you need to fill in some fields:

`account.user_token`

`account.access_token`

`account.user_id`

Optional: `account.yandex_key` used by Yandex API

Optional: `account.weather_key` used by WorldWeatherOnline API

# Starting

After that you're ready to start bot with `lua vk.lua`
