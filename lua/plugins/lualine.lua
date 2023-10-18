local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#88D97B',
    orange   = '#FEA405',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#7FCEFF',
    red      = '#e95678',
    bg_visual = "#b3deef",
}

local mode_color = {
    n = colors.blue,
    i = colors.green,
    v = colors.bg_visual,
    V = colors.bg_visual,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
}
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}
local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    event="VeryLazy",
}

function M.config()

    local lualine = require('lualine')
    local config = {
        extensions = { "lazy" },
        options = {
            -- Disable sections and component separators
            disabled_filetypes = {     -- Filetypes to disable lualine for.
                statusline = {"NvimTree","diffpanel",'alpha'},      -- only ignores the ft for statusline.
                winbar = {"NvimTree","diffpanel",'alpha'},          -- only ignores the ft for winbar.
            },
            globalstatus = true,
            component_separators = '',
            section_separators = '',
            theme = {
                -- We are going to use lualine_c an lualine_x as left and
                -- right section. Both are highlighted by c theme .  So we
                -- are just setting default looks o statusline
                normal = { c = { fg = colors.fg, bg = "None" } },
                inactive = { c = { fg = colors.fg, bg = "None" } },
            },
        },
        sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            -- These will be filled later
            lualine_c = {},
            lualine_x = {},
        },
        inactive_sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
        },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
    end

    
    -- Mode --
    ins_left {
        -- mode component
        function()
            Mode_text = {
                n      = 'NORMAL',
                i      = 'INSERT',
                c      = 'COMMAND',
                v      = 'VISUAL',
                V      = 'V-LINE',
                [''] = 'V-BLOCK',
                R      = 'REPLACE',
                t      = 'TERMINAL',
            }
            return '  '..( Mode_text[vim.fn.mode()] or vim.fn.mode() )
        end,
        color = function() return { fg = mode_color[vim.fn.mode()],gui = 'bold',bg='None' } end,
        padding = { right = 1 },
    }



    -- Filename & Icon --
    local file_icon, icon_color, cterm_color = require('nvim-web-devicons').get_icon_colors(vim.fn.expand('%:t'))
    ins_left {
        function () return vim.fn.expand('%:t') end,
        cond = conditions.buffer_not_empty,
        color = function () return { fg = (icon_color or mode_color[vim.fn.mode()]), gui = 'bold',bg='None' } end
    }

    -- Location & Progress --
    ins_left { 'location', color = { fg = colors.yellow, bg='None' } }
    ins_left { 'progress', color = { fg = colors.yellow, bg='None' } }



    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    
    -- LSP --
    ins_left {
        function() return '%=' end  -- Must be here
    }
    ins_left {
        -- Lsp server name .
        function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end,
        icon = file_icon,
        color = function() return { fg = ( icon_color or mode_color[vim.fn.mode()] ),gui = 'bold',bg='None' } end,
    }
    
    -- Diagnostic --
    ins_right {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
            error = " ",
            warn  = " ",
            info  = " ",
            hint  = "󰝶 ",
        },
        diagnostics_color = {
            color_error = { fg = colors.red,bg='None' },
            color_warn = { fg = colors.yellow,bg='None' },
            color_info = { fg = colors.cyan,bg='None' },
            color_hint = { fg = colors.fg,bg='None' },
        },
    }
    
    -- Diff --
    ins_right {
        'diff',
        -- Is it me or the symbol for modified us really weird
        --symbols = { added = ' ', modified = ' ', removed = ' ' },
        diff_color = {
            added = { fg = colors.green,bg='None' },
            modified = { fg = colors.orange,bg='None' },
            removed = { fg = colors.red,bg='None' },
        },
        cond = conditions.hide_in_width,
    }

    -- Encoding type --
    ins_right {
        'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.yellow, gui = 'bold',bg='None' },
    }

    -- Lazy status --
    ins_right{
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = colors.green },
    }


    -- OS --
    local os = vim.loop.os_uname().sysname
    if os == "Linux" then
        os = io.popen("lsb_release -i -s"):read("*l")
    end
    ins_right {
        function ()
            local os_icons ={
                ["Windows"]= '',
                ["Darwin"] = '',
                ["Debian"] = '',
                ["Ubuntu"] = ''
            }
            return (os_icons[os] or '')
        end,
        color = function ()
            local os_color = {
                ["Windows"] = {fg = "#087CD5", bg='None'},
                ["Darwin"]  = {fg = "#A9B3B9", bg='None'},
                ["Debian"]  = {fg = "#D91857", bg='None'},
                ["Ubuntu"]  = {fg = "#DD4814", bg='None'},
            }
            return (os_color[os] or {fg = "#88D97B", bg='None'})
        end
    }

    -- Branch --
    ins_right {
        'branch',
        icon = '',
        color = { fg = colors.magenta, gui = 'bold',bg='None' },
    }

    -- Copilot --
    local status = require("copilot.api").status.data
    ins_right{
        function ()
            local copilot_status = {
                [""] = ' ',
                ["Normal"] = ' ',
                ["Warning"] = ' ',
                ["InProgress"] = ' ',
                ["Error"] = ' ',
            }
            return copilot_status[status.status] .. (status.message or "")
        end,
        color = function ()
            local copilot_colours = {
                [""] = { fg = '#00f4ff', bg = 'None' },
                ["Normal"] = { fg = '#00f4ff',bg = 'None' },
                ["Warning"] = { fg = colors.orange, bg = 'None' },
                ["InProgress"] = { fg = colors.yellow, bg = 'None' },
                ["Error"] = { fg = colors.yellow, bg = 'None' },
            }
            return copilot_colours[status.status]
        end
    }

    --ins_left {
        --function() return '▊' end,
        --color = function() return { fg = mode_color[vim.fn.mode()],bg='None'  } end,
        --padding = { left = 0, right = 1 }, -- We don't need space before this
    --}
    --ins_right {
        --function() return '▊' end,
        --color = function() return { fg = mode_color[vim.fn.mode()],bg='None'  } end,
        --padding = { left = 1}, -- We don't need space before this
    --}
    lualine.setup(config)
end
return M
