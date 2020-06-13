function command_help ( message )
	if message ==  "помощь" then
		send_message( account, 
			"Бот целиком и полностью написанный на Lua" .. "\n" .. 
			"Список команд: " .. "\n" .. 
			"1 ... видео {название}" .. "\n" .. 
			"2 ... пикча {название}" .. "\n" ..
			"3 ... фибоначчи | fibonacci {число}" .. "\n" .. 
			"4 ... факториал | factorial {число}" .. "\n" .. 
			"5 ... rgb to hex {0...255, 0...255, 0...255}" .. "\n" .. 
			"6 ... hex to rgb {#шестизначное hex-число}" .. "\n" ..
			"7 ... calc {выражение}" .. "\n" .. 
			"8 ... equ {квадратный трёхчлен} (для тупеньких, ax^2+bx+c)" .. "\n" ..
			"9 ... regex {(регулярное выражение)} {текст}")
	end
end