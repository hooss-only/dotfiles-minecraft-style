local cmp = require('cmp')

cmp.setup({
        mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-o>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-y>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
        }),
        sources = cmp.config.sources({
                        { name = 'nvim_lsp' }
                }, {
                        { nane = 'buffer' }
                }
        )
})
