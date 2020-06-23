require "lib"
require "auth"  --init `account` variable
require "modules/module_admin/lib_admin"
require "modules/module_admin/commands_admin"
require "modules/module_math/lib_math"
require "modules/module_math/commands_math"
require "modules/module_handling_api/command_video_search"
require "modules/module_handling_api/command_pic_search"
require "modules/module_help/command_help"
require "modules/module_regex/command_regex"
require "modules/module_translate/command_translate"
require "modules/module_weather/command_weather"
require "command_list"

local server 		= get_lp_server()
local lp_server 	= server["response"]["server"]
local lp_key 		= server["response"]["key"]
local lp_ts 		= server["response"]["ts"]

local start_time = os.date('%H:%M:%S')

while true do

	answer =	request(lp_server,
			{act = "a_check", key = lp_key,
			ts = lp_ts, wait = "60"})

	if answer_not_empty(answer) then

		lp_ts = answer["ts"]

		message	= answer["updates"][1]["object"]["message"]["text"]
		from_id	= answer["updates"][1]["object"]["message"]["from_id"]
		account.peer	= answer["updates"][1]["object"]["message"]["peer_id"]

		if from_id ~= 562486732 then

		local question = message:find("?") --index

		local first_symbol = 1

		init_commands ( message )

			if message and question == first_symbol then
					
				print(os.date("%c") .. " -> " .. message)
				-- if you want to create log file

				command_help			( message )

				if video_match then
					command_video_search( user_token, video_match )
				end

				if pic_match then
					command_pic_search	( user_token, pic_match )
				end

				if translate_match then
					command_translate	( translate_match )
				end	

				if weather_match then
					command_weather		( weather_match )
				end

				if fac_match then
					command_factorial	( fac_match )
				end

				if fib_match then
					command_equation	( fib_match )
				end

				if regex_match then
					command_regex		( regex_match )
				end

				if to_rgb_match then
					command_hex_to_rgb	( to_rgb_match )
				end

				if to_hex_match then
					command_rgb_to_hex	( to_hex_match )
				end

				if stat_match then
						command_bot_stat( start_time )
				end

				if from_id == account.user_id then

					if bash_match then
						bash		( bash_match )
					end

					if lua_match then
						lua_exec	( message )
					end

				else
					error_403		( message )
				end
			end
		end
	end

	if answer_not_empty(answer) ~= true then
		server 		= get_lp_server()
		lp_server 	= server["response"]["server"]
		lp_key 		= server["response"]["key"]
		lp_ts 		= server["response"]["ts"]
	end
end
