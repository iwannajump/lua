local vk 			= require "lib"
local user_id 			= 123
local account 			= vk.make_account("mail@gmail.com", "passwd") --костыль под выпил
local user_token		= "" 	-- user
account.access_token		= ""	-- group
account.api_version		= "5.52"

while true do

	local long_poll_server 	= vk.call(account, "groups.getLongPollServer", { group_id = "" })
	local lp_server 	= long_poll_server["response"]["server"]
	local lp_key 		= long_poll_server["response"]["key"]
	local lp_ts 		= long_poll_server["response"]["ts"]

	local answer = 		request(lp_server,
				{act = "a_check", key = lp_key,
				ts = lp_ts, wait = "30"})

	if answer_not_empty(answer) == true then

		message 	= answer["updates"][1]["object"]["message"]["text"]
		account.peer 	= answer["updates"][1]["object"]["message"]["peer_id"]
		from_id 	= answer["updates"][1]["object"]["message"]["from_id"]
		
		if message ==  "помощь" then
	    	send_message	( account, "Бот целиком и полностью написанный на Lua" .. "\n" .. 
					"Список команд: " .. "\n" .. 
					"1 ... видео {название}" .. "\n" .. 
					"2 ... фибоначчи | fibonacci {число}" .. "\n" .. 
					"3 ... факториал | factorial {число}" .. "\n" .. 
					"4 ... rgb to hex {0...255, 0...255, 0...255}" .. "\n" .. 
					"5 ... hex to rgb {#шестизначное hex-число}" .. "\n" ..
					"6 ... calc {выражение}" .. "\n" .. 
					"7 ... equ {уравнение}" .. "\n" ..
					"8 ... regex {(регулярное выражение)} {текст}"
				)
		end

		command_block( account, "тест", "ок")	-- под выпил

		if message then
			print(message)

			local video_match = message:match "^видео%s(.*)$"  or message:match "^Видео%s(.*)$"
			if video_match ~= nil then
				local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = user_token, v = "5.52" })
				if video["response"]["items"][1] ~= nil then
					send_video(account, video["response"]["items"][1]["owner_id"], video["response"]["items"][1]["id"])
				end
			end

			local fib_match = 	message:match "^фибоначчи%s(.*)$"  or 
						message:match "^fibonacci%s(.*)$" 
			if fib_match ~= nil then
				fib_match = tonumber(fib_match)
				if fib_match ~= nil then
					send_message(account, "F(" ..  fib_match .. ") = " .. fibonacci(fib_match))
				else
					send_message(account, "аргумент не является натуральным числом")
				end
			end

			local fac_match =	message:match "^факториал%s(.*)$" or 
						message:match "^factorial%s(.*)$"
			if fac_match ~= nil then
				fac_match = tonumber(fac_match)
				if fac_match ~= nil then
					send_message(account, fac_match .. "! = " .. factorial(fac_match))
				else
					send_message(account, "аргумент не является натуральным числом")
				end
			end

			local hex_to_rgb_match = message:match "^hex to rgb%s(.*)$"
			if hex_to_rgb_match ~= nil then
				send_message(account, hex_to_rgb(hex_to_rgb_match))
			end

			local rgb_to_hex_match = message:match "^rgb to hex%s(.*)$"
			if rgb_to_hex_match ~= nil then
				send_message(account, rgb_to_hex(rgb_to_hex_match))
			end
			
			local calc_match = message:match "^calc%s([^%$].*)$"
			if calc_match ~= nil then 
				calc_match = calc_match:gsub("%s", "")
				local exec_result = os_exec("wcalc " .. calc_match)
				send_message(account, calc_match .. exec_result)
			end

			local equation_match = message:match "^equ%s(.*)$"
			if equation_match ~= nil then
				equation_match = equation_match:gsub("%s", "")
				local equation_result = quadratic(equation_match)
				send_message(account, equation_result)
			end

			local regex_match = message:match "^regex%s(.*)$"
			if regex_match ~= nil then
				local regex 	= 	regex_match:match "%((.*)%)%s"
				regex 		= 	string.gsub(regex, "\\", "%%")
				local text 	= 	regex_match:match "%)%s.*$"
				text  		)= 	text:gsub ("%)", "")
				send_message(account, match_regex(regex, text))
			end

			if from_id == user_id then

				--		BASH
				local os_match = message:match "^os%s(.*)$"
				if os_match ~= nil then
					local exec_result = os_exec(os_match)
					send_message(account, exec_result)

					if exec_result == "" then
						send_message(account, "command not found: " .. os_match)
					end
				end

				--		LUA
				local lua_result = compile("^lua%s(.*)$", "CODE_TO_EXEC/main.lua", "lua CODE_TO_EXEC/main.lua")
				send_message(account, lua_result)
			else

				local access_denied_match = message:match "^lua%s(.*)$" or message:match "^os%s(.*)$"
				if access_denied_match ~= nil then
					send_message(account, "access denied")
				end	
			end
		end
	end
end
