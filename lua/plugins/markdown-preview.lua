return{
    'iamcco/markdown-preview.nvim',
    lazy = true,
    event = {'BufEnter *.md', "BufRead *.md", "BufNewFile *.md" },
    --build = "cd app && npm install",
    --build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
        vim.fn["mkdp#util#install"]()
        vim.keymap.set('n', '<leader>md', "<CMD>MarkdownPreview<CR>", { noremap = true, silent = true })
        vim.g.mkdp_auto_close = true
        vim.g.mkdp_open_to_the_world = false
        vim.g.mkdp_open_ip = "127.0.0.1"
        vim.g.mkdp_port = "8888"
        --vim.g.mkdp_browser = ""
        vim.g.mkdp_echo_preview_url = false
        vim.g.mkdp_page_title = "${name}"
        vim.g.mkdp_theme = 'dark'
        --local install_path = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
        --local node_modules = install_path .. "/node_modules"
        --if vim.fn.empty(vim.fn.glob(node_modules)) > 0 then
            --vim.cmd("!cd " .. install_path .. " && npm install")
        --end
    end,
}
