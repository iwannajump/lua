function command_translate ( message )
	local trans_match = message:match "[Пп]ереводчик%s(.*)$"
	if trans_match then
		local result = translate ({ text = trans_match, lang = "ru" })
		send_message( account, result["text"][1])
	end
end
