function command_fibonacci ( message )
	message = tonumber(message)
	if message then
		send_message( "F(" ..  message .. ") = " .. fibonacci(message))
	else
		send_message( "аргумент не является натуральным числом")
	end
end

function command_factorial ( message )
		message = tonumber(message)
		if message then
			send_message( message .. "! = " .. factorial(message))
		else
			send_message( "аргумент не является натуральным числом")
		end
end

function command_equation ( message )
	local equation_match = message:match "[Ee]qu%s(.*)$"
	if equation_match then
		equation_match = equation_match:gsub("%s", "")
		local equation_result = quadratic(equation_match)
		send_message( equation_result)
	end
end

-- function command_calculator ( message )
-- 	local calc_match = message:match "[Cc]alc%s([^%$%`].*)$"
-- 	if calc_match then 
-- 		calc_match = calc_match:gsub("%s", "")
-- 		local exec_result = os_exec("wcalc " .. calc_match)
-- 			send_message( calc_match .. exec_result)
-- 	end
-- end

function command_hex_to_rgb ( message )
	send_message( hex_to_rgb(message))
end

function command_rgb_to_hex ( message )
	send_message( rgb_to_hex(message))
end