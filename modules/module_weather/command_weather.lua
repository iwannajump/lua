function command_weather ( message )
	local weather_match = message:match "[Пп]огода%s(.*)$"
	if weather_match then
		local result = weather ({ q = weather_match })
		if result["data"]["current_condition"] then
			send_message( account, "Сейчас в " .. weather_match .. " " .. result["data"]["current_condition"][1]["temp_C"] .. "℃")
		end
	end
end