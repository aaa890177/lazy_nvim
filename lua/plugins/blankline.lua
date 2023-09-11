local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    --event = 'VeryLazy',
    --enabled = false,
}

function M.config()
    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#98C379 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#56B6C2 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#61AFEF gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent5 guifg=#C678DD gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent6 guifg=#E06C75 gui=nocombine]]
    vim.opt.list = true
    --vim.opt.listchars:append "space:⋅"
    require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = false,
        show_current_context_start = true,
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
    }
end


--function M.config()
    --vim.opt.termguicolors = true
    --vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
    --vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

    --require("indent_blankline").setup {
        --char = "",
        --char_highlight_list = {
            --"IndentBlanklineIndent1",
            --"IndentBlanklineIndent2",
        --},
        --space_char_highlight_list = {
            --"IndentBlanklineIndent1",
            --"IndentBlanklineIndent2",
        --},
        --show_trailing_blankline_indent = false,
    --}
--end


return M
