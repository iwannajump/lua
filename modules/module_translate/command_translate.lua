function command_translate ( message )
	local result = translate ({ text = message, lang = "ru" })
	if result ~= nil then send_message( result["text"][1]) end
end
