local M = {}


M.open_entry = function(opts)
  local path = opts.path

  if opts.date == nil then
    local year = os.date("%Y")
    local month = os.date("%m")
    local day = os.date("%d")
    os.execute("mkdir -p "..path.."/"..year)
    vim.cmd(":e "..path.."/"..year.."/"..year.."-"..month.."-"..day..".md")
  end
end

return M
