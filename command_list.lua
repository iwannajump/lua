function init_commands()
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

	command_help
	( message )

	if video_match then
		command_video_search
		( user_token, video_match )
	end

	if pic_match then
		command_pic_search
		( user_token, pic_match )
	end

	if translate_match then
		command_translate
		( translate_match )
	end	

	if weather_match then
		command_weather	
		( weather_match )
	end

	if fac_match then
		command_factorial
		( fac_match )
	end

	if fib_match then
		command_equation
		( fib_match )
	end

	if regex_match then
		command_regex
		( regex_match )
	end

	if to_rgb_match then
		command_hex_to_rgb
		( to_rgb_match )
	end

	if to_hex_match then
		command_rgb_to_hex
		( to_hex_match )
	end

	if stat_match then
		command_bot_stat
		( start_time )
	end

	if from_id == account.user_id then

		if bash_match then
			bash
			( bash_match )
		end

		if lua_match then
			lua_exec
			( message )
		end

	else
		error_403
		( message )
	end
end