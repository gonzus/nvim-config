local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  vim.notify("Could not require module 'indent_blankline'")
  return
end

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "space:"
vim.opt.listchars:append "eol:↴"

indent_blankline.setup({
  use_treesitter = true,
  filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
  },
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
})
