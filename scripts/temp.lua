function conky_temp()
  local handle = io.popen("/home/.conky/scripts/temperature.sh conky")
  local result = handle:read("*a")
  handle:close()
  return result
end
