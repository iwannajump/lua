function os_exec(str)
   local  res = io.popen(str)
   local  ex  = res:read("*a")
   return ex
end

function compile (compile_match, exec_file, exec_command)
   local match = message:match(compile_match)
   if match ~= nil then
      local file = io.open(exec_file, "w")
      file:write(match)
      local exec_result = os_exec(exec_command)
      return exec_result
   end
end