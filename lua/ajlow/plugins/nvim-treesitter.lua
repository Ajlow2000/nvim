return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/playground",
        },
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
            treesitter.setup({ -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "c",
                    "cpp",
                    "rust",
                    "go",
                    "ocaml",
                    "python",
                    "nix",
                    "norg",
                    "csv",
                    "json",
                    "yaml",
                    "html",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "lua",
                    "vim",
                    "dockerfile",
                    "gitignore",
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                auto_install = true,
            })
        end,
    },
}
