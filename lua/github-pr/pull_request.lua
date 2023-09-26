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

---@return string
M.pull_request = function()
  local fn = vim.fn.expand("%")
  print(fn)

  local output = ""
  -- TODO: Get relative path to the root, perhaps move to separate function so we can add a test for it, perhaps move to separate function so we can add a test for it.
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- url = string.format('%s/blob/%s/%s?plain=1#L%s', repo, branch, path, cursor_pos[1])
  vim.fn.jobstart("gh pr " .. fn .. ":1", {
    on_stdout = function(_, d, _)
      output = output .. vim.fn.join(d)
      print(output)
    end,
  })

  -- local job = vim.fn.jobstart('gh version', {
  --         -- cwd = '/path/to/working/dir',
  --         on_exit = function ()
  --             print "on exit"
  --         end,
  --         on_stdout = function ()
  --            print "on stdout"
  --         end,
  --         on_stderr = function ()
  --            print "on stderr"
  --         end
  --     }
  -- )
  return M.config.opt
end

return M
