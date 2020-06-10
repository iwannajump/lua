function command_fibonacci ( message )
	local fib_match = 	message:match "^фибоначчи%s(.*)$"  or 
						message:match "^fibonacci%s(.*)$" 
	if fib_match then
		fib_match = tonumber(fib_match)
		if fib_match then
			send_message(account, "F(" ..  fib_match .. ") = " .. fibonacci(fib_match))
		else
			send_message(account, "аргумент не является натуральным числом")
		end
	end
end

function command_factorial ( message )
	local fac_match = 	message:match "^факториал%s(.*)$" or 
						message:match "^factorial%s(.*)$"
	if fac_match then
		fac_match = tonumber(fac_match)
		if fac_match then
			send_message(account, fac_match .. "! = " .. factorial(fac_match))
		else
			send_message(account, "аргумент не является натуральным числом")
		end
	end
end

function command_equation ( message )
	local equation_match = message:match "^equ%s(.*)$"
		if equation_match then
		equation_match = equation_match:gsub("%s", "")
		local equation_result = quadratic(equation_match)
		send_message(account, equation_result)
	end
end

function command_calculator ( message )
	local calc_match = message:match "^calc%s([^%$].*)$"
	if calc_match then 
		calc_match = calc_match:gsub("%s", "")
		local exec_result = os_exec("wcalc " .. calc_match)
			send_message(account, calc_match .. exec_result)
	end
end

function command_hex_to_rgb ( message )
	local hex_to_rgb_match = message:match "^hex to rgb%s(.*)$"
	if hex_to_rgb_match then
		send_message(account, hex_to_rgb(hex_to_rgb_match))
	end
end

function command_rgb_to_hex ( message )
	local rgb_to_hex_match = message:match "^rgb to hex%s(.*)$"
	if rgb_to_hex_match then
		send_message(account, rgb_to_hex(rgb_to_hex_match))
	end
end