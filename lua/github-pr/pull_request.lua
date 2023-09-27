local popup = require "plenary.popup"
local Job = require('plenary.job')


---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
}

---@class BrowseModule
local M = {}

---@type Config
M.config = config

---@param args Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end


local function create_border_popup(borderchars)
  local _, config = popup.create("popup with custom border", {
    line = 8,
    col = 55,
    padding = { 0, 3, 0, 3 },
    borderchars = borderchars,
  })
  local border_id = config.border.win_id
  local border_bufnr = vim.api.nvim_win_get_buf(border_id)
  print(border_id)
  print(border_bufnr)
end

---@return string
M.pull_request = function()

-- local opts = {
--     \ "on_stdout": function("s:RgEvent"),
--     \ "on_stderr": function("s:RgEvent"),
--     \ "on_exit": function("s:RgEvent"),
--     \ "pattern": a:pattern
--     \ }
--     let s:rg_job = jobstart(a:cmd, opts)
local output = ""
  vim.fn.jobstart("gh pr create", {
    on_stdout = function(_, d, _)
        output = output .. vim.fn.join(d)
        print(output)
    end,
  })

  return M.config.opt
end

return M
