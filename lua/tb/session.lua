local function getCurrentDir()
  local cwd = vim.fn.getcwd()
  local lastSlashIndex = string.find(cwd, "/[^/]*$")
  if lastSlashIndex == nil then lastSlashIndex = 1 end
  return string.sub(cwd, lastSlashIndex, string.len(cwd))
end

local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  else
    return false
  end
end

local function save_session()
  local dir = getCurrentDir()
  vim.cmd("!mkdir -p session" .. dir)
  vim.cmd("mksession! session" .. dir .. "/session.vim")
end

local function restore_session()
  local dir = getCurrentDir()
  local session = "session" .. dir .. "/session.vim"
  if file_exists(session) then
    vim.cmd("source session" .. dir .. "/session.vim")
  end
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = save_session,
  pattern = "*",
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = restore_session,
  nested = true,
  pattern = "*",
})
