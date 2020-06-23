function command_regex ( message )
		local regex = 	message:match "%((.*)%)%s"
if regex then regex = 	string.gsub(regex, "\\", "%%") end
		local text 	= 	message:match "%)%s.*$"
	if text then
		text 		= 	text:gsub ("%)", "")
			send_message( text:match(regex))
	end
end