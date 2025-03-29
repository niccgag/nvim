if vim.uv.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "pwsh.exe"
end

vim.opt.shiftwidth = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})
