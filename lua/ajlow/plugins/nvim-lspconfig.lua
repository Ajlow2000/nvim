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
                    diagnostic = {
                        globals = { "vim" },
                        undefined_global = false, -- remove this from diag!
                        missing_parameters = false,
                    },
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
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { silent = true, desc = "[LSP] - Open Floating Diag"})
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true, desc = "[LSP] - Go to prev"})
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true, desc = "[LSP] - Go to next"})
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { silent = true, desc = "[LSP] - Set loclist"})

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, silent = true, desc = "[LSP] - Goto Declaration"})
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, silent = true, desc = "[LSP] - Goto definition"})
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, silent = true, desc = "[LSP] - Hover"})
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, silent = true, desc = "[LSP] - Goto implementation"})
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, silent = true, desc = "[LSP] - Signature Help"})
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, silent = true, desc = "[LSP] - Add workspace folder"})
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, silent = true, desc = "[LSP] - Remove workspace folder"})
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = ev.buf, silent = true, desc = "[LSP] - List workspace folders"})
                vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, { buffer = ev.buf, silent = true, desc = "[LSP] - Goto type definition"})
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = ev.buf, silent = true, desc = "[LSP] - Rename"})
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, silent = true, desc = "[LSP] - Code actions"})
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, silent = true, desc = "[LSP] - Goto references"})
                vim.keymap.set('n', '<space>=', function()
                    vim.lsp.buf.format { async = true }
                end, { buffer = ev.buf, silent = true, desc = "[LSP] - Format file"})
            end,
        })
    end
}
