-- Header

local function header()
    local arthur = {
        " ,.  ,-.  ,---. .  . .  . ,-.  ",
        "/  \\ |  )   |   |  | |  | |  ) ",
        "|--| |-<    |   |--| |  | |-<  ",
        "|  | |  \\   |   |  | |  | |  \\ ",
        "'  ' '  '   '   '  ' `--` '  ' ",
    }
    local arthur_1 = {
    " ▄▄▄       ██▀███  ▄▄▄█████▓ ██░ ██  █    ██  ██▀███  ",
    "▒████▄    ▓██ ▒ ██▒▓  ██▒ ▓▒▓██░ ██▒ ██  ▓██▒▓██ ▒ ██▒",
    "▒██  ▀█▄  ▓██ ░▄█ ▒▒ ▓██░ ▒░▒██▀▀██░▓██  ▒██░▓██ ░▄█ ▒",
    "░██▄▄▄▄██ ▒██▀▀█▄  ░ ▓██▓ ░ ░▓█ ░██ ▓▓█  ░██░▒██▀▀█▄  ",
    " ▓█   ▓██▒░██▓ ▒██▒  ▒██▒ ░ ░▓█▒░██▓▒▒█████▓ ░██▓ ▒██▒",
    " ▒▒   ▓▒█░░ ▒▓ ░▒▓░  ▒ ░░    ▒ ░░▒░▒░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░",
    "  ▒   ▒▒ ░  ░▒ ░ ▒░    ░     ▒ ░▒░ ░░░▒░ ░ ░   ░▒ ░ ▒░",
    "  ░   ▒     ░░   ░   ░       ░  ░░ ░ ░░░ ░ ░   ░░   ░ ",
    "      ░  ░   ░               ░  ░  ░   ░        ░     ",
    "                                                      ",
    }
	return arthur_1
end
-- Footer
local function footer()
	local version = vim.version()
	local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
	local datetime = os.date("%Y/%m/%d %H:%M:%S")

	return {
		--" ",
		print_version .. " - " .. datetime,
	}
end

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = header()
        dashboard.section.footer.val = footer()

        -- Menu
        -- TODO: Add projects and Frecency?
        dashboard.section.buttons.val = {
            dashboard.button("e",       "  New file", ":ene <BAR> startinsert<CR>"),
            dashboard.button("<F2>",    "  Terminal", "<cmd>terminal<CR>i"),
            dashboard.button("LDR f r", "󰔠  Recent files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("LDR f f", "  Find files", "<cmd>Telescope find_files<CR>"),
            dashboard.button("LDR f g", "󰊄  Find text", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("LDR f p", "󱠏  Projects", "<cmd>lua require'telescope'.extensions.project.project{}<CR>"),
            --dashboard.button("LDR p c", "  Config", "<cmd>e $MYVIMRC<CR>"),
            dashboard.button("LDR   L", "  Plugins", "<cmd>Lazy<CR>"),
            --dashboard.button("LDR q", "  Quit", "<cmd>qa<CR>"),
        }

        alpha.setup(dashboard.config)
    end,
}
--return{
    --{
        --'goolord/alpha-nvim',
        ----enabled = false,
        --lazy=false,
        --ement = "VimEnter",
        --dependencies = { 'nvim-tree/nvim-web-devicons' },
        --config = function ()
            ----require'alpha'.setup(require'alpha.themes.startify'.config)
            --require'alpha'.setup(require'alpha.themes.dashboard'.config)
        --end
    --}
--}
