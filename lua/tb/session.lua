local function get_session_dir()
  local cwd = vim.fn.getcwd()
  local lastSlashIndex = string.find(cwd, "/[^/]*$")
  if lastSlashIndex == nil then lastSlashIndex = 1 end
  local current_dir = string.sub(cwd, lastSlashIndex, string.len(cwd))
  local session_dir = vim.fn.stdpath("config") .. "/session" .. current_dir
  print(session_dir)
  return session_dir
end
vim.api.nvim_create_user_command("SessionDir", get_session_dir, {})

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
  vim.cmd("!mkdir -p " .. get_session_dir())
  vim.cmd("mksession! " .. get_session_dir() .. "/session.vim")
end

local function restore_session()
  local session = get_session_dir() .. "/session.vim"
  if file_exists(session) then
    vim.cmd("source " .. get_session_dir() .. "/session.vim")
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
