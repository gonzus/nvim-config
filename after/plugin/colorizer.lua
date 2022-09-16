local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  vim.notify("Could not require module 'colorizer'")
  return
end

colorizer.setup({})
