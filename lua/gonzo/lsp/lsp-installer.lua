local status_mason_ok, mason_installer = pcall(require, "mason")
if not status_mason_ok then
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
  return
end

local servers = {
  -- "lua-language-server",
  "sumneko_lua",
  "zls",
}
mason_lspconfig_installer.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local status_lspconfig_ok, lspconfig_installer = pcall(require, "lspconfig")
if not status_lspconfig_ok then
  return
end

mason_lspconfig_installer.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    lspconfig_installer[server_name].setup{}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["sumneko_lua"] = function ()
    local opts = {
      on_attach = require("gonzo.lsp.handlers").on_attach,
      capabilities = require("gonzo.lsp.handlers").capabilities,
    }
    local sumneko_opts = require "gonzo.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    lspconfig_installer["sumneko_lua"].setup(opts)
  end,
})

-- for _, name in ipairs(servers) do
--   -- opts = {
--   --   on_attach = require("gonzo.lsp.handlers").on_attach,
--   --   capabilities = require("gonzo.lsp.handlers").capabilities,
--   -- }
--
--   -- if server == "sumneko_lua" then
--   --   local sumneko_opts = require "gonzo.lsp.settings.sumneko_lua"
--   --   opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--   -- end
--
--   local ok, server = lspconfig_installer[name].setup{}
-- end
