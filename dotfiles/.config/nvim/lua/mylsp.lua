local opts = { noremap = true, silent = true }

local on_attach = function(_, _)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	-- vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

require('lspconfig').clangd.setup{
	on_attach=on_attach,
	cmd = {
	  "clangd",
	  "--background-index",
	  "--pch-storage=memory",
	  "--all-scopes-completion",
	  "--pretty",
	  "--header-insertion=never",
	  "-j=4",
	  "--inlay-hints",
	  "--header-insertion-decorators",
	  "--function-arg-placeholders",
	  "--completion-style=detailed"
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
	capabilities = capabilities
}

require("lspconfig").qmlls.setup {
        cmd = {
                "/usr/lib/qt6/bin/qmlls"
        },
        capabilities = capabilities
}
