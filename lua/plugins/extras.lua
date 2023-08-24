return{
    {
        'NvChad/nvim-colorizer.lua',
        --'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function ()
            --require'colorizer'.setup({})
            require("colorizer").attach_to_buffer(0, { mode = "background", css = true})
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        --event = 'VeryLazy',
    },
    {
        'dstein64/vim-startuptime',
        event = 'VeryLazy',
    },
    {
        "nathom/filetype.nvim",
        --lazy=true
        event = 'VeryLazy',
    },
    {
        "sindrets/diffview.nvim",
        event = 'VeryLazy',
    },
    {
        'scrooloose/nerdcommenter',
        event = 'VeryLazy',
    },
    {
        'iamcco/markdown-preview.nvim',
        lazy = true,
        event = {'BufEnter *.md', "BufRead *.md", "BufNewFile *.md" },
        config = function()
            vim.fn["mkdp#util#install"]()
            vim.keymap.set('n', '<leader>md', "<CMD>MarkdownPreview<CR>", { noremap = true, silent = true })
        end,
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
                    local_path = '/Document/images', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
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
        lazy=true,
    }
}
