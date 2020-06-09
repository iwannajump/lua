local vk 	= require "lib"

function bash ( account, message )
	local os_match = message:match "^os%s(.*)$"
	if os_match ~= nil then
		local exec_result = os_exec(os_match)
		send_message(account, exec_result)
		if exec_result == "" then
			send_message(account, "command not found: " .. os_match)
		end
	end
end

function lua_exec ( account, message )
	local lua_result = compile("^lua%s(.*)$", "CODE_TO_EXEC/main.lua", "lua CODE_TO_EXEC/main.lua")
	send_message(account, lua_result)
end

function error_403_message ( account, message )
	local e403 = message:match "^lua%s(.*)$" or message:match "^os%s(.*)$"
	if e403 ~= nil then
		send_message(account, "access denied")
	end	
end