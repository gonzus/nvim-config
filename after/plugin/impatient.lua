local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  vim.notify("Could not require module 'impatient'")
  return
end
