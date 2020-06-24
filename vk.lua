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

get_lp_server()
start_time = os.date('%H:%M:%S') --neded by bot_stat command

while true do
	answer = request(lp_server, {act = "a_check", key = lp_key, ts = lp_ts, wait = "60"})
	if answer_not_empty(answer) then
		lp_ts = answer["ts"]
		message		= answer["updates"][1]["object"]["message"]["text"]
		from_id		= answer["updates"][1]["object"]["message"]["from_id"]
		account.peer 	= answer["updates"][1]["object"]["message"]["peer_id"]
		local question	= message:find("?") --index
		if message and question == 1 and from_id ~= 562486732 then
			init_commands(message)
			print(os.date("%c") .. " -> " .. message)
			--[[if you want to create log file,
			you can add `>> log` to execute
			command to save stdout
			output into file]]
		end
	end
	if answer_not_empty(answer) ~= true then
		get_lp_server()
	end
end
