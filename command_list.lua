function init_commands ( message )
	video_match 	= message:match "[Вв]идео%s(.*)$"
	fac_match 	= message:match "[Фф]акториал%s(.*)$"
	pic_match 	= message:match "[Пп]икча%s(.*)$"
	translate_match	= message:match "[Пп]ереводчик%s(.*)$"
	weather_match 	= message:match "[Пп]огода%s(.*)$"
	fib_match 	= message:match "[Фф]ибоначчи%s(.*)$"
	regex_match 	= message:match "[Rr]egex%s(.*)$"
	to_rgb_match 	= message:match "[Tt]o rgb%s(.*)$"
	to_hex_match 	= message:match "[Tt]o hex%s(.*)"
	bash_match 	= message:match "[Oo]s%s(.*)$"
	stat_match 	= message:match "[Сс]тат$"
	lua_match 	= message:match "[Ll]ua%s(.*)$"
end
