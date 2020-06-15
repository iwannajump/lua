function command_regex ( message )
	local regex_match = message:match "[Rr]egex%s(.*)$"
	if regex_match then
			local regex = 	regex_match:match "%((.*)%)%s"
	if regex then regex = 	string.gsub(regex, "\\", "%%") end
			local text 	= 	regex_match:match "%)%s.*$"
		if text then
			text 		= 	text:gsub ("%)", "")
				send_message(account, text:match(regex))
		end
	end
end