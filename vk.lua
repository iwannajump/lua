local vk 						= require "lib"
local admin_lib 				= require "module_admin/lib_admin"
local admin_commands 			= require "module_admin/admin_commands"
local math_lib 					= require "module_math/lib_math"
local math_commands 			= require "module_math/math_commands"
local regex_command 			= require "module_regex/regex_command"
local vk_api_commands 			= require "module_handling_api/vk_api_commands"
local auth 						= require "auth"				--init account variable

while true do

	local long_poll				= call(account, "groups.getLongPollServer", { group_id = "192764727" })
	local lp_server 			= long_poll["response"]["server"]
	local lp_key 				= long_poll["response"]["key"]
	local lp_ts 				= long_poll["response"]["ts"]

	local answer = 				request(lp_server,
								{act = "a_check", key = lp_key,
								ts = lp_ts, wait = "30"})

	if answer_not_empty(answer) == true then

		message 				= answer["updates"][1]["object"]["message"]["text"]
		from_id 				= answer["updates"][1]["object"]["message"]["from_id"]
		account.peer 			= answer["updates"][1]["object"]["message"]["peer_id"]
			
		if message ==  "помощь" then
	    send_message( account, 	"Бот целиком и полностью написанный на Lua" .. "\n" .. 
								"Список команд: " .. "\n" .. 
								"1 ... видео {название}" .. "\n" .. 
								"2 ... фибоначчи | fibonacci {число}" .. "\n" .. 
								"3 ... факториал | factorial {число}" .. "\n" .. 
								"4 ... rgb to hex {0...255, 0...255, 0...255}" .. "\n" .. 
								"5 ... hex to rgb {#шестизначное hex-число}" .. "\n" ..
								"6 ... calc {выражение}" .. "\n" .. 
								"7 ... equ {квадратный трёхчлен} (для тупеньких, ax^2+bx+c)" .. "\n" ..
								"8 ... regex {(регулярное выражение)} {текст}")
		end

		if message then

			command_video_search( account, user_token, message )

			command_fibonacci 	( account, message )

			command_factorial 	( account, message )

			command_equation 	( account, message )

			command_calculator 	( account, message )

			command_regex		( account, message )

			command_hex_to_rgb 	( account, message )

			command_rgb_to_hex 	( account, message )

			if from_id == account.user_id then

				bash ( account, message )

				lua_exec ( account, message )

			else
				error_403_message ( account, message )
			end
		end
	end
end
