return {
    {
        'xorid/asciitree.nvim',
        cmd = { 'AsciiTree', 'AsciiTreeUndo' },
        opt = {
            depth = 2,
            delimiter = "#",
            symbols = {
                child  = "├",
                last   = "└",
                parent = "│",
                dash   = "─",
                blank  = " ",
            },
        }
    },
    {
        "tadmccorkle/markdown.nvim",
        ft = { "markdown" },
        config = function()
            require("markdown").setup()
        end
    },
    {
        "SCJangra/table-nvim",
        ft = { "markdown" },
        opts = {
            padd_column_separators = true, -- Insert a space around column separators.
            mappings = {                   -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
                -- next = '<TAB>',
                -- prev = '<S-TAB>',
                next                = '<A-]>',   -- Go to next cell.
                prev                = '<A-[>',   -- Go to previous cell.
                insert_row_up       = '<A-k>',   -- Insert a row above the current row.
                insert_row_down     = '<A-j>',   -- Insert a row below the current row.
                move_row_up         = '<A-S-k>', -- Move the current row up.
                move_row_down       = '<A-S-j>', -- Move the current row down.
                insert_column_left  = '<A-h>',   -- Insert a column to the left of current column.
                insert_column_right = '<A-l>',   -- Insert a column to the right of current column.
                move_column_left    = '<A-S-h>', -- Move the current column to the left.
                move_column_right   = '<A-S-l>', -- Move the current column to the right.
                insert_table        = '<A-t>',   -- Insert a new table.
                insert_table_alt    = '<A-S-t>', -- Insert a new table that is not surrounded by pipes.
                delete_column       = '<A-d>',   -- Delete the column under cursor.
            }
        }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { "markdown", "Avante" },
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        opts = {
            file_types = { "markdown", "Avante" },
            render_modes = true,
            code = {
                width     = 'block',
                left_pad  = 2,
                right_pad = 4,
            },
        },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#76A2F6", bg = "#23273B" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#DEB06D", bg = "#2D282C" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#9DCD66", bg = "#252C2C" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = "#15C19E", bg = "#182931" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = "#BA99F7", bg = "#29273A" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = "#9B80D0", bg = "#262336" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#76A2F6" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#DEB06D" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#9DCD66" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#15C19E" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#BA99F7" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#9B80D0" })
            vim.api.nvim_set_hl(0, "MarkdownH1", { fg = "#76A2F6" })
            vim.api.nvim_set_hl(0, "MarkdownH2", { fg = "#DEB06D" })
            vim.api.nvim_set_hl(0, "MarkdownH3", { fg = "#9DCD66" })
            vim.api.nvim_set_hl(0, "MarkdownH4", { fg = "#15C19E" })
            vim.api.nvim_set_hl(0, "MarkdownH5", { fg = "#BA99F7" })
            vim.api.nvim_set_hl(0, "MarkdownH6", { fg = "#9B80D0" })
            vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1d1f26" })
            require('render-markdown').setup(opts)
        end
    },
    {
        'arthur-hsu/pastify.nvim',
        cmd = { 'Pastify' },
        config = function()
            require('pastify').setup {
                opts = {
                    absolute_path = false,                              -- use absolute or relative path to the working directory
                    apikey        = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path    = '/screenshot/',                     -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    -- save          = 'online',                           -- Either 'local' or 'online'
                    save          = 'local',                            -- Either 'local' or 'online'
                },
                ft = {                                                  -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html     = '<img src="$IMG$" alt="">',
                    markdown = '![image]($IMG$)',
                    tex      = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        -- build = function() vim.fn["mkdp#util#install"]() end,
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        config = function()
            vim.keymap.set('n', '<leader>md', "<CMD>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
            vim.g.mkdp_auto_close        = true
            vim.g.mkdp_open_to_the_world = false
            vim.g.mkdp_open_ip           = "127.0.0.1"
            vim.g.mkdp_port              = "8888"
            --vim.g.mkdp_browser         = ""
            vim.g.mkdp_echo_preview_url  = false
            vim.g.mkdp_page_title        = "${name}"
            vim.g.mkdp_theme             = 'dark'
        end
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = function()
            local platform = vim.loop.os_uname().sysname
            -- local tmpdir = vim.fn.stdpath("cache")
            if platform == "Windows_NT" then
                vim.cmd("!irm https://deno.land/install.ps1 | iex")
            else
                vim.cmd("!curl -fsSL https://deno.land/install.sh | sh")
            end
            return "deno task --quiet build:fast"
        end,
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },


}
