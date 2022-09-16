local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  vim.notify("Could not require module 'Comment'")
  return
end

comment.setup {}
