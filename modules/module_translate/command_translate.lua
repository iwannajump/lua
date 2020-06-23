function command_translate ( message )
	local result = translate ({ text = message, lang = "ru" })
	send_message( result["text"][1])
end
