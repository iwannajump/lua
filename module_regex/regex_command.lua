function command_regex( account, message )
	local regex_match = message:match "^regex%s(.*)$"
	if regex_match then
		local regex = 	regex_match:match "%((.*)%)%s"
			  regex = 	string.gsub(regex, "\\", "%%")
		local text 	= 	regex_match:match "%)%s.*$"
			  text  = 	text:gsub ("%)", "")
		send_message(account, text:match(regex))
	end
end