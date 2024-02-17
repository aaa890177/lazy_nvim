return{
    {
        'NvChad/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        --event = 'VeryLazy',
        config = function ()
            require'colorizer'.setup({})
            --require("colorizer").attach_to_buffer(0, { mode = "background", css = true})
        end
    },
    {
        'xiyaowong/transparent.nvim',
        lazy=false,
        event="VimEnter",
        config= function ()
            require("transparent").setup({ -- Optional, you don't have to run setup.
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                -- table: additional groups that should be cleared
                extra_groups = {
                    "Folded",
                    "FoldColumn",
                    "UfoCursorFoldedLine",
                    "UfoFoldedBg"
                },
                -- table: groups you don't want to clear
                exclude_groups = {
                    "NotifyBackground",
                    'CursorLineNr',
                },
            })
            require('transparent').clear_prefix('lualine')
            
        end
    },
    {
        'tzachar/local-highlight.nvim',
        event = 'VeryLazy',
        config = function()
            require('local-highlight').setup({
                -- file_types = {'python', 'cpp'}, -- If this is given only attach to this
                -- -- OR attach to every filetype except:
                -- disable_file_types = {'tex'},
                -- hlgroup = 'Search',
                -- cw_hlgroup = nil,
                -- -- Whether to display highlights in INSERT mode or not
                -- insert_mode = false,
            })
            -- vim.cmd [[LocalHighlightOn]]
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        -- opts ={
        --     override = {
        --         toml = {
        --             icon = "󰙩",
        --             color = "#ffffff",
        --             cterm_color = "231",
        --             name = "Toml",
        --         }
        --     }
        -- }
    },
    {
        "nathom/filetype.nvim",
        event = "VimEnter",
        --event = 'VeryLazy',
    },
    {
        "sindrets/diffview.nvim",
        event = 'VeryLazy',
    },
    {
        'TobinPalmer/pastify.nvim',
        lazy = true,
        event = {'BufEnter *.md', "BufRead *.md", "BufNewFile *.md" },
        cmd = { 'Pastify' },
        config = function ()
            require('pastify').setup {
                opts = {
                    absolute_path = false, -- use absolute or relative path to the working directory
                    apikey = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path = '/screenshot/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    save = 'local', -- Either 'local' or 'online'
                },
                ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html = '<img src="$IMG$" alt="">',
                    markdown = '![image]($IMG$)',
                    tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    },
    {
        'lithammer/nvim-pylance',
        enabled = false,
        lazy=true,
    },
    {
        'junegunn/vim-easy-align',
        enabled = false,
        event="VeryLazy",
    },
    {
        'dstein64/vim-startuptime',
        event="VimEnter",
        enabled = false,
    }
}
