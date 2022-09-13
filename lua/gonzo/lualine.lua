local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  vim.notify("Could not require module 'lualine'")
  return
end

local diagnostics = {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	sections = { 'error', 'warn' },
	symbols = { error = ' ', warn = ' ' },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local filetype = {
	'filetype',
	icons_enabled = false,
	icon = nil,
}

local branch = {
	'branch',
	icons_enabled = true,
	icon = '',
}

local location = {
	'location',
	padding = 0,
}

local options = {
	options = {
    theme = 'nord',
		component_separators = '',
		section_separators = '',
		disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline' },
	},
	sections = {
		lualine_a = { 'filename' },
		lualine_b = { branch },
		lualine_c = { diagnostics },
    lualine_x = { 'encoding', filetype },
		lualine_y = { 'progress' },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = { 'filename' },
		lualine_b = {},
		lualine_c = {},
    lualine_x = { 'encoding', filetype },
		lualine_y = { 'progress' },
		lualine_z = { location },
	},
}
lualine.setup(options)
