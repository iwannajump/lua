function os_exec( command )
   local  exec = io.popen(command)
   exec = exec:read("*a")
   return exec
end

function compile ( compile_match, exec_file, exec_command )
   local match = message:match(compile_match)
   if match then
      local file = io.open(exec_file, "w")
      file:write(match)
      local exec_result = os_exec(exec_command)
      return exec_result
   end
end