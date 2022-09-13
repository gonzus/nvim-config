-- For now, add here the servers we know about
local known_lsp_servers = {
  "sumneko_lua",
  "zls",
  "clangd",
  "sqls",
}

local status_mason_ok, mason_installer = pcall(require, "mason")
if not status_mason_ok then
  vim.notify("Could not require module 'mason'")
  return
end

mason_installer.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
    check_outdated_packages_on_open = true,
  }
}

local status_mason_lspconfig_ok, mason_lspconfig_installer = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig_ok then
  vim.notify("Could not require module 'mason-lspconfig'")
  return
end

mason_lspconfig_installer.setup {
  ensure_installed = known_lsp_servers,
  automatic_installation = true,
}

local status_lspconfig_ok, lspconfig_installer = pcall(require, "lspconfig")
if not status_lspconfig_ok then
  vim.notify("Could not require module 'lspconfig'")
  return
end

local handler_config = require("gonzo.lsp.handlers")
local handlers = {
  function (server_name) -- default handler (optional)
    lspconfig_installer[server_name].setup{}
  end,
}
for _, server_name in ipairs(known_lsp_servers) do
  handlers[server_name] = function ()
    local opts = {
      on_attach = handler_config.on_attach,
      capabilities = handler_config.capabilities,
    }
    local settings = "gonzo.lsp.settings." .. server_name
    local status_ok, server_opts = pcall(require, settings)
    if status_ok then
      -- print("GONZO: adding server opts for " .. server_name .. " from " .. settings)
      opts = vim.tbl_deep_extend("force", server_opts, opts)
    else
      -- print("GONZO: using server " .. server_name .. " with default opts")
    end
    lspconfig_installer[server_name].setup(opts)
  end
end

mason_lspconfig_installer.setup_handlers(handlers)
