function hex_to_rgb( hex )
   if #hex == 7 then 
      local r = string.sub(hex, 2, 3)
      local g = string.sub(hex, 4, 5)
      local b = string.sub(hex, 6, 7)

      r = tonumber(r, 16)
      g = tonumber(g, 16)
      b = tonumber(b, 16)
      if (r and g and b) ~= nil then
         return string.format("%d, %d, %d", r, g, b)
      else
         return "неправильное число"
      end
   end 
   if #hex ~= 7 then
      return "неправильное число"
   end
end

function rgb_to_hex( rgb )
   local    r = rgb:match("%d+")
   local    g = rgb:match("%s%d+%s")
   local    b = rgb:match("%d+$")

   if ( r and g and b ) ~= nil then
      r = tonumber(r, 10)
      g = tonumber(g, 10)
      b = tonumber(b, 10)

      if r < 16 then
         r = string.format("0%x", r)
      else
         r = string.format("%x", r)
      end

      if g < 16 then
         g = string.format("0%x", g)
      else
         g = string.format("%x", g)
      end

      if b < 16 then
         b = string.format("0%x", b)
      else
         b = string.format("%x", b)
      end

      return string.format("#" .. r .. g .. b)
   end

   if ( r or g or b ) == nil then
      return "неправильное число"
   end
end

function fibonacci( n )
   if n > 35 then
      return 0
   end
   if n < 3 then
      return 1
   else
      return fibonacci(n-1) + fibonacci(n-2)
   end
end

function factorial ( n )
   if n > 20 then
      return 0
   end
   if n < 2 then
      return 1
   else
      return n * factorial( n - 1)
   end
end

function quadratic ( equ )
   local a = equ:match "^-?%d+"
      if a == nil then a = 1 end

   local b = equ:match("-?%d+x[+-]%d+")
      if b ~= nil then b = b:match("-?%d+") end
      if b == nil then b = 1 end

   local c = equ:match("-?%d+$")

   if  ( a and b and c ) ~= nil then
      local d = b^2 - 4 * ( a*c )

      if d > 0 then
         local  x1   = ( -b - math.sqrt(d) ) / 2 / a
         local  x2   = ( -b + math.sqrt(d) ) / 2 / a
         return "x1 = " .. x1 .. "\nx2 = " .. x2
      end

      if d == 0 then
         local x1    =  - ( b  / ( 2 * a ))
         return "x1 = " .. x1
      end

      if d < 0 then
         return "D < 0"
      end
   end
end