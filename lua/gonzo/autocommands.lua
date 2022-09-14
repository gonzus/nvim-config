local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local automatic_group = create_augroup("AutomaticGroup", { clear = true })

-- jump to the last position when reopening a file
create_autocmd({ "BufReadPost" }, {
  group = automatic_group,
  pattern = { "*" },
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
})

-- strip trailing whitespace on save
create_autocmd({ "BufWritePre" }, {
  group = automatic_group,
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
