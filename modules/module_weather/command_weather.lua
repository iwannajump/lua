function command_weather ( message )
	local result = weather ({ q = message })
	if result["data"]["current_condition"] then
		city = result["data"]["request"][1]["query"]
		temp = result["data"]["current_condition"][1]["temp_C"]
		description = result["data"]["current_condition"][1]["lang_ru"][1]["value"]
		send_message( "Сейчас в " 	.. city .. " " .. temp .. "℃" .. "\n"
									.. description)
	end
end