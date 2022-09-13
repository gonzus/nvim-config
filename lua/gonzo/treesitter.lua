local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("Could not require module 'nvim-treesitter.configs'")
  return
end

configs.setup {
  ensure_installed = { "c", "lua", "zig" },
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing

  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of languages that will be disabled
    additional_vim_regex_highlighting = true,
  },

  indent = {
    enable = true,
    disable = { "" }, -- list of languages that will be disabled
  },

  rainbow = {
    enable = true,
    disable = { "" }, -- list of languages that will be disabled
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  },
}
