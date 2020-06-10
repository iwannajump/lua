local vk 						= require "lib"
local admin_lib 				= require "module_admin/lib_admin"
local admin_commands 			= require "module_admin/admin_commands"
local math_lib 					= require "module_math/lib_math"
local math_commands 			= require "module_math/math_commands"
local vk_api_commands 			= require "module_handling_api/vk_api_commands"
local help_command 				= require "module_help/help_command"
local regex_command 			= require "module_regex/regex_command"
local auth 						= require "auth"  --init `account` variable

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
			
		command_help( message )

		if message then

			command_video_search( user_token, message )

			command_pic_search 	( user_token, message )

			command_fibonacci 	( message )

			command_factorial 	( message )

			command_equation 	( message )

			command_calculator 	( message )

			command_regex		( message )

			command_hex_to_rgb 	( message )

			command_rgb_to_hex 	( message )

			if from_id == account.user_id then

				bash ( message )

				lua_exec ( message )

			else
				error_403 ( message )
			end
		end
	end
end
