function bash ( message )
	send_message( os_exec(message .. " 2>&1") )
end

function command_bot_stat( start_time )
	send_message( "Bot launched at " .. start_time .. "\n" ..
			"Uptime: " .. os_exec("./modules/module_admin/process_uptime.sh lua") .. "\n" ..
			"RAM Used: " .. string.format("%.2f KiB", collectgarbage("count")) .. "\n" ..  
			os_exec("./modules/module_admin/cpu_usage.sh lua"))
end

function lua_exec ( message )
	local lua_result = compile("[Ll]ua%s(.*)$", "main.lua", "lua main.lua")
	send_message( lua_result)
end

function error_403 ( message )
	if message:match "[Ll]ua%s(.*)$" or message:match "[Oo]s%s(.*)$" then
		send_message( "access denied")
	end	
end
