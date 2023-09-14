return {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --     "folke/neodev.nvim",
    -- },
    config = function()
        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        -- require("neodev").setup({
            -- override = function(root_dir, library)
            --     if root_dir:find("$XDG_CONFIG_HOME/home-manager/dotfiles/nvim", 1, true) == 1 then
            --         library.enabled = true
            --         library.plugins = true
            --     end
            -- end,
        -- })

        -- then setup your lsp server as usual
        local lspconfig = require('lspconfig')

        -- example to setup lua_ls and enable call snippets
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                }
            }
        })

        -- Setup language servers.
        lspconfig.nixd.setup {}
        lspconfig.bashls.setup {}
        lspconfig.gopls.setup {}
        lspconfig.ocamllsp.setup {}
        lspconfig.rust_analyzer.setup {}
        lspconfig.pyright.setup {}
        lspconfig.clangd.setup {}



        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>=', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end,
        })
    end
}
