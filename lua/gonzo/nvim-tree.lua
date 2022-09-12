local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
nvim_tree.setup()
