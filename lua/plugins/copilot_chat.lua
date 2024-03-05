local prompt = function(input)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
end
return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        event = "VeryLazy",
        dependencies = {
            { "zbirenbaum/copilot.lua" },                 -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },                  -- for curl, log wrapper
            { "nvim-telescope/telescope.nvim" },          -- for telescope help actions (optional)
        },
        opts = {
            model = 'gpt-4',                              -- GPT model to use
            temperature = 0.1,                            -- GPT temperature
            debug = false,                                -- Enable debug logging
            show_user_selection = true,                   -- Shows user selection in chat
            show_system_prompt = false,                   -- Shows system prompt in chat
            show_folds = true,                            -- Shows folds for sections in chat
            clear_chat_on_new_prompt = false,             -- Clears chat on every new prompt
            auto_follow_cursor = true,                    -- Auto-follow cursor in chat
            name = 'CopilotChat',                         -- Name to use in chat
            separator = '---',                            -- Separator to use in chat
            window = {
                layout = 'vertical',                      -- 'vertical', 'horizontal', 'float'
                                                          -- Options below only apply to floating windows
                relative = 'editor',                      -- 'editor', 'win', 'cursor', 'mouse'
                border = 'rounded',                       -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                width = 0.8,                              -- fractional width of parent
                height = 0.6,                             -- fractional height of parent
                row = nil,                                -- row position of the window, default is centered
                col = nil,                                -- column position of the window, default is centered
                title = '  CopilotChat ',                -- title of chat window
                footer = nil,                             -- footer of chat window
                zindex = 1,                               -- determines if window is on top or below other floating windows
            },
            mappings = {
                close = "q",                              -- Close chat
                reset = "<C-l>",                          -- Clear the chat buffer
                complete = "<Tab>",                       -- Change to insert mode and press tab to get the completion
                submit_prompt = "<CR>",                   -- Submit question to Copilot Chat
                accept_diff = "<C-a>",                    -- Accept the diff
                show_diff = "<C-s>",                      -- Show the diff
            },
        },

        config = function(_,opts)
            local select = require("CopilotChat.select")

            opts.selection = function(source)
                local startPos = vim.fn.getpos("'<")
                local endPos   = vim.fn.getpos("'>")
                local startLine, startCol = startPos[2], startPos[3]
                local endLine,   endCol   = endPos[2],   endPos[3]


                if startLine ~= endLine or startCol ~= endCol then
                    return select.visual(source)
                else
                    return select.buffer(source)
                end
            end

            local prompts = {
                Explain     = { prompt = "解釋這段代碼如何運行。" },
                FixError    = { prompt = "請解釋以上代碼中的錯誤並提供解決方案。" },
                Suggestion  = { prompt = "請查看以上代碼並提供改進建議的sample code。" },
                Annotations = { prompt = "幫以上代碼加入註解" },
                Refactor    = { prompt = "請重構以上代碼以提高其清晰度和可讀性。" },
                Tests       = { prompt = "簡要說明以上代碼的工作原理，然後產生單元測試。" },
                Commit = {
                    prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    selection = select.gitdiff,
                },
                CommitStaged = {
                    prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    selection = function(source)
                        return select.gitdiff(source, true)
                    end,
                },
            }
            opts.prompts = prompts
            require("CopilotChat").setup(opts)

            -- NOTE: This function creates an unordered list.
            -- local options = {}
            -- table.insert(options, "Quick Chat")
            -- table.insert(options, "Quick Chat with file type")
            -- for key, value in pairs(prompts) do
            --     table.insert(options, key)
            -- end
            
            -- NOTE: So we need to create an ordered list.
            local options = {
                "Quick Chat",
                "Quick Chat with filetype",
                "Explain",
                "FixError",
                "Suggestion",
                "Annotations",
                "Refactor",
                "Tests",
                "Commit",
                "CommitStaged",
            }


            local pickers      = require "telescope.pickers"
            local finders      = require "telescope.finders"
            local conf         = require("telescope.config").values
            local actions      = require "telescope.actions"
            local action_state = require "telescope.actions.state"
            local Chat_cmd     = "CopilotChat"


            local Telescope_CopilotActions = function(opts)
                opts = opts or {}
                pickers.new(opts, {
                    prompt_title = "Select Copilot prompt",
                    finder = finders.new_table { results = options },
                    sorter = conf.generic_sorter(opts),

                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            local choice = selection[1]
                            local get_type = vim.api.nvim_buf_get_option(0, 'filetype')
                            local FiletypeMsg = Chat_cmd .. " " .. "這是一段 ".. get_type .. " 代碼, "
                            if string.find(choice, 'Quick Chat') then
                                local input = vim.fn.input("Quick Chat: ")
                                if string.find(choice, 'with filetype') then
                                    Ask_msg = FiletypeMsg .. input
                                else
                                    Ask_msg = input
                                end
                                if input ~= "" then
                                    require("CopilotChat").ask(Ask_msg)
                                end
                            else
                                local msg = ""
                                -- Find the item message base on the choice
                                for item, body in pairs(prompts) do
                                    if item == choice then
                                        msg = body.prompt
                                        break
                                    end
                                end
                                local Ask_msg = FiletypeMsg .. msg
                                require("CopilotChat").ask(Ask_msg)
                            end
                        end)
                        return true
                    end,
                }):find()
            end

            vim.api.nvim_create_user_command("CopilotActions",
                function() Telescope_CopilotActions(require("telescope.themes").get_dropdown{ selection_caret = " " }) end,
                { nargs = "*", range = true }
            )

        end,

        keys = {
            {
                '<leader>cci',
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input)
                    end
                end,
                desc = " CopilotChat - Quick chat",
                mode = {"n","v","x"}
            },
            {
                '<leader>ccp',
                function()
                    -- require("CopilotChat.code_actions").show_prompt_actions()
                    vim.cmd("CopilotActions")
                end,
                desc = " CopilotChat - Prompt actions",
                mode = {"n","v","x"}
            },
            { '<leader>cco', "<cmd>CopilotChatOpen<cr>",        desc = " CopilotChat - Open chat",          mode = {"n", "v", "x"} },
            { '<leader>ccq', "<cmd>CopilotChatClose<cr>",       desc = " CopilotChat - Close chat",         mode = {"n", "v", "x"} },
            { '<leader>cct', "<cmd>CopilotChatToggle<cr>",      desc = " CopilotChat - Toggle chat",        mode = {"n", "v", "x"} },
            { '<leader>ccR', "<cmd>CopilotChatReset<cr>",       desc = " CopilotChat - Reset chat",         mode = {"n", "v", "x"} },
            { '<leader>ccD', "<cmd>CopilotChatDebugInfo<cr>",   desc = " CopilotChat - Show diff",          mode = {"n", "v", "x"} },

            { '<leader>cce', "<cmd>CopilotChatExplain<cr>",     desc = " CopilotChat - Explain code",       mode = {"n", "v", "x"} },
            { '<leader>ccT', "<cmd>CopilotChatFixError<cr>",    desc = " CopilotChat - Fix Error",          mode = {"n", "v", "x"} },
            { '<leader>ccr', "<cmd>CopilotChatSuggestion<cr>",  desc = " CopilotChat - Provide suggestion", mode = {"n", "v", "x"} },
            { '<leader>ccF', "<cmd>CopilotChatRefactor<cr>",    desc = " CopilotChat - Refactor code",      mode = {"n", "v", "x"} },
            { '<leader>ccA', "<cmd>CopilotChatAnnotations<cr>", desc = " CopilotChat - Add a comment",      mode = {"n", "v", "x"} },
        }
    },
}
