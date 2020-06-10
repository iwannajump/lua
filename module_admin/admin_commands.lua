function bash ( message )
	local os_match = message:match "^os%s(.*)$"
	if os_match then
		local exec_result = os_exec(os_match)
		send_message(account, exec_result)
		if exec_result == "" then
			send_message(account, "command not found: " .. os_match)
		end
	end
end

function lua_exec ( message )
	local lua_result = compile("^lua%s(.*)$", "main.lua", "lua main.lua")
	send_message(account, lua_result)
end

function error_403 ( message )
	if (message:match "^lua%s(.*)$" or message:match "^os%s(.*)$") ~= nil then
		send_message(account, "access denied")
	end	
end