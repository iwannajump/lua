function bash ( message )
	local os_match = message:match "^[Oo]s%s(.*)$"
	if os_match then
		send_message(account, os_exec(os_match))
		if os_exec(os_match) == "" then
			send_message(account, "command not found: " .. os_match)
		end
	end
end

function command_mem_usage( message )
	if message == "память" then
		send_message(account, os_exec("./modules/module_admin/mem.sh lua"))
	end
end

function lua_exec ( message )
	local lua_result = compile("^[Ll]ua%s(.*)$", "main.lua", "lua main.lua")
	send_message(account, lua_result)
end

function error_403 ( message )
	if (message:match "^lua%s(.*)$" or message:match "^os%s(.*)$") ~= nil then
		send_message(account, "access denied")
	end	
end