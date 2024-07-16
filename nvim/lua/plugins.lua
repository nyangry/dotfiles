-- debug
-- local function dump(o)
--   if type(o) == 'table' then
--     local s = '{ '
--     for k,v in pairs(o) do
--       if type(k) ~= 'number' then k = '"'..k..'"' end
--       s = s .. '['..k..'] = ' .. dump(v) .. ','
--     end
--     return s .. '} '
--   else
--     return tostring(o)
--   end
-- end

-- keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

return {
  -- colorscheme
  {
    'EdenEast/nightfox.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd("colorscheme nightfox")
    end
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 3 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 3 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    event = "BufRead",
    config = function ()
      local nvim_tree = require("nvim-tree")

      nvim_tree.setup({
        view = {
          width = 70,
        },
      })

      vim.keymap.set({ "n" }, "<leader>t", ":NvimTreeFindFile<CR>", opts)
      vim.keymap.set({ "n" }, "<leader>tt", ":NvimTreeToggle<CR>", opts)
    end
  },

  -- syntax provider
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "python", "kotlin", "ruby", "lua", "vim", "sql", "graphql", "json", "yaml", "javascript", "html", "markdown", "markdown_inline"},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- context support for nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    config = function ()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end
  },

  -- textsubjects for nvim-treesitter
  {
    'RRethy/nvim-treesitter-textsubjects',
    event = "BufRead",
    config = function ()
      require('nvim-treesitter.configs').setup {
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
          },
        },
      }
    end
  },

  -- code outline window
  {
    'stevearc/aerial.nvim',
    event = "BufRead",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local aerial = require("aerial")

      aerial.setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end
  },

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          -- sorting_strategy = "descending",
        },
        pickers = {
          -- live_grep = {
          --   attach_mappings = function(prompt_bufnr, map)
          --     local function file_only(prompt_bufnr)
          --       local picker = action_state.get_current_picker(prompt_bufnr)
          --       local results = picker.finder.results
          --       local unique_files = {}
          --       local unique_display = {}
          --
          --       for _, result in ipairs(results) do
          --         local file = result.filename
          --         if not unique_files[file] then
          --           unique_files[file] = true
          --           table.insert(unique_display, file)
          --         end
          --       end
          --
          --       picker:refresh(finders.new_table {
          --         results = unique_display,
          --         entry_maker = make_entry.gen_from_file(),
          --       }, { reset_prompt = true })
          --     end
          --
          --     map('i', '<C-u>', file_only)
          --     map('n', '<C-u>', file_only)
          --     return true
          --   end,
          -- },
        },
      })

      local builtin = require('telescope.builtin')

      -- ファイル名のみでlive_grep
      local function live_grep_file_only()
        builtin.live_grep({
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "-l",
            "--smart-case",
          },
        })
      end

      -- 行番号付きでlive_grep
      local function live_grep_with_line_numbers()
        builtin.live_grep({
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        })
      end

      vim.keymap.set('n', '<C-f>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
      vim.keymap.set('n', '<leader>gcb', builtin.git_bcommits, {})
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
      vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
      vim.keymap.set('n', '<leader>gst', builtin.git_stash, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<C-g>', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>fr', builtin.resume, {})
      vim.keymap.set('n', '<leader>qf', builtin.quickfix, {})
      vim.keymap.set('n', '<leader>qh', builtin.quickfixhistory, {})
      vim.keymap.set('n', '<leader>gr', live_grep_file_only, {})
      vim.keymap.set('n', '<leader>grn', live_grep_with_line_numbers, {})
      -- vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
    end
  },

  -- use fzf for telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    event = "VeryLazy",
    config = function()
      require("telescope").setup({
        defaults = {
          -- vimgrep_arguments = {
          --   -- ripggrepコマンドのオプション
          --   "rg",
          --   "--sort=path",
          --   "--color=never",
          --   "--no-heading",
          --   "--with-filename",
          --   "--line-number",
          --   "--column",
          --   "--smart-case",
          -- },
        },
        extensions = {
          -- ソート性能を大幅に向上させるfzfを使う
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      require("telescope").load_extension("fzf")
    end
  },

  -- MRU provider for telescope
  {
    'nvim-telescope/telescope-frecency.nvim',
    event = "VeryLazy",
    config = function()
      require('telescope').load_extension 'frecency'

      vim.keymap.set('n', '<C-m>', '<Cmd>Telescope frecency workspace=CWD<CR>')
    end,
  },

  -- file browser extension for telescope
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "file_browser"
    end
  },

  {
    'hrsh7th/cmp-nvim-lsp',
    event = "BufRead",
    config = function()
    end
  },

  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    event = "BufRead",
    config = function()
    end
  },

  {
    'hrsh7th/cmp-buffer',
    event = "BufRead",
    config = function()
    end
  },

  {
    'hrsh7th/cmp-path',
    event = "BufRead",
    config = function()
    end
  },

  {
    'hrsh7th/cmp-cmdline',
    event = "BufRead",
    config = function()
    end
  },

  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    config = function()
      -- Set up nvim-cmp.
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          documentation =  {
            max_width = 0,
            max_height = 0
          }
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if entry == nil then
                fallback()
              else
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                })
              end
            else
              fallback()
            end
          end, {'i', 's'}),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          -- { name = 'vsnip' },
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
        }, {
        }),
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        }
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
            { name = 'buffer' },
          })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
          { name = 'buffer' },
        }, {
            { name = 'cmdline' }
          })
      })

      -- Additional setup for :%s to use buffer and path sources
      cmp.setup.cmdline(':%s', {
        sources = cmp.config.sources({
          { name = 'buffer' },
          { name = 'path' }
        })
      })
    end
  },
  {
    'hrsh7th/cmp-vsnip',
    event = "BufRead",
    config = function()
    end
  },
  {
    'hrsh7th/vim-vsnip',
    event = "BufRead",
    config = function()
    end
  },

  -- snippet
  { "rafamadriz/friendly-snippets" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    event = "BufRead",
    config = function()
      local ls = require("luasnip")

      vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

      vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, {silent = true})
      require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })
    end
  },

  -- It allows you to quickly select, yank, delete or replace language-specific ranges.
  {
    'David-Kunz/treesitter-unit',
    event = "BufRead",
    config = function()
      keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
      keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
      keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
      keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})
    end
  },

  -- git sign
  {
    'lewis6991/gitsigns.nvim',
    event = "BufRead",
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup {
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      }
      keymap('n', '<leader>bf', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', opts)
      keymap('n', '<leader>b', '<cmd>lua require"gitsigns".blame_line()<CR>', opts)
    end
  },
  --  indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "BufRead",
    config = function ()
      local ibl = require("ibl")
      ibl.setup()
    end
  },

  -- removes trailing white space and empty lines on BufWritePre
  {
    "mcauley-penney/tidy.nvim",
    event = "BufRead",
    config = true,
  },

  -- mkdir
  {
    'jghauser/mkdir.nvim',
    event = "BufRead",
  },

  -- highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  {
    'RRethy/vim-illuminate',
    event = "BufRead",
    config = function ()
    end
  },

  -- A high-performance color highlighter for Neovim
  {
    'norcalli/nvim-colorizer.lua',
    event = "BufRead",
    config = function ()
      require'colorizer'.setup()
    end
  },

  -- Operator
  {
    'kana/vim-operator-replace',
    dependencies = { 'kana/vim-operator-user' },
    event = "BufRead",
    config = function()
      keymap("n", "R", "<Plug>(operator-replace)", opts)
      keymap("v", "R", "<Plug>(operator-replace)", opts)
      -- keymap("i", "R", "<Plug>(operator-replace)", opts)
    end
  },

  -- keyword Jump
  {
    'echasnovski/mini.jump',
    event = "BufRead",
    config = function()
      local mini_jump = require('mini.jump')
      mini_jump.setup()
    end
  },

  -- Comment
  {
    'echasnovski/mini.comment',
    event = "BufRead",
    config = function ()
      require('mini.comment').setup({
        -- Options which control module behavior
        options = {
          -- Function to compute custom 'commentstring' (optional)
          custom_commentstring = nil,

          -- Whether to ignore blank lines when commenting
          ignore_blank_line = false,

          -- Whether to recognize as comment only lines without indent
          start_of_line = false,

          -- Whether to force single space inner padding for comment parts
          pad_comment_parts = true,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = '--',

          -- Toggle comment on current line
          comment_line = '--',

          -- Toggle comment on visual selection
          comment_visual = '--',

          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          -- Works also in Visual mode if mapping differs from `comment_visual`
          textobject = '--',
        },
      })
    end
  },

  -- surround
  {
    'echasnovski/mini.surround',
    event = "BufRead",
    config = function ()
      require('mini.surround').setup()
    end
  },

  -- pair
  -- {
  --   'echasnovski/mini.pairs',
  --   version = '*',
  --   config = function ()
  --     require('mini.pairs').setup()
  --   end
  -- },

  -- autoclose and autorename html tag / js / jsx / markdown / tsx / typescript / vue / xml
  {
    'windwp/nvim-ts-autotag',
    event = "BufRead",
    config = function ()
      require'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
        }
      }
    end
  },

  -- increment / decrement
  {
    'monaqa/dial.nvim',
    event = "BufRead",
    config = function ()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group{
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
        },
      }
      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
    end
  },

  -- yankring
  {
    "gbprod/yanky.nvim",
    event = "BufRead",
    opts = {},
    config = function ()
      vim.keymap.set("n", "<C-p>", "<Plug>(YankyPreviousEntry)", opts)
      vim.keymap.set("n", "<C-n>", "<Plug>(YankyNextEntry)", opts)
    end
  },

  -- translate

  {
    'uga-rosa/translate.nvim',
    event = "BufRead",
    config = function ()
      local translate = require("translate")
      translate.setup({
        default = {
          command = "translate_shell",
        },
        preset = {
          output = {
            split = {
              append = true,
            },
          },
        },
      })

      vim.keymap.set({ "n" }, "<C-e>", ":<C-u>Translate EN<CR>", opts)
      -- vim.keymap.set({ "n" }, "<C-j>", ":<C-u>Translate JA<CR>", opts)
      vim.keymap.set({ "n" }, "<space>te", ":<C-u>Translate EN<CR>", opts)
      vim.keymap.set({ "n" }, "<space>tj", ":<C-u>Translate JA<CR>", opts)
      vim.keymap.set({ "n" }, "<space>tei", ":<C-u>Translate EN -output=insert<CR>", opts)
      vim.keymap.set({ "n" }, "<space>tji", ":<C-u>Translate JA -output=insert<CR>", opts)
      vim.keymap.set({ "v" }, "<space>te", ":Translate EN<CR>", opts)
      vim.keymap.set({ "v" }, "<space>tj", ":Translate JA<CR>", opts)
      vim.keymap.set({ "v" }, "<space>tei", ":Translate EN -output=insert<CR>", opts)
      vim.keymap.set({ "v" }, "<space>tji", ":Translate JA -output=insert<CR>", opts)
    end
  },

  -- venv
  -- {
  --   'linux-cultist/venv-selector.nvim',
  --   dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  --   opts = {
  --     -- Your options go here
  --     -- name = "venv",
  --     -- auto_refresh = false
  --   },
  --   event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  --   keys = {
  --     -- Keymap to open VenvSelector to pick a venv.
  --     { '<leader>vs', '<cmd>VenvSelect<cr>' },
  --     -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
  --     { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  --   },
  -- },

  -- action preview
  -- {
  --   "aznhe21/actions-preview.nvim",
  --   config = function()
  --     vim.keymap.set({ "v", "n" }, "<C-c>", require("actions-preview").code_actions)
  --   end,
  -- },

  -- annotation / docstring generator
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    event = "BufRead",
    config = function()
      vim.g.doge_doc_standard_python = "sphinx" -- Default: reST
      vim.g.doge_python_settings = {
        single_quotes = 0,
        omit_redundant_param_types = 0
      }
    end
  },

  -- test runner
  {
    "klen/nvim-test",
    event = "BufRead",
    config = function()
      local nvim_test = require('nvim-test')
      nvim_test.setup({
        termOpts = {
          direction = "vertical", -- terminal's direction ("horizontal"|"vertical"|"float")
          width = 100,               -- terminal's width (for vertical|float)
          height = 70,              -- terminal's height (for horizontal|float)
        },
      })

      local nvim_test_runners_python = require("nvim-test.runners.pytest")
      nvim_test_runners_python:setup{
        -- https://github.com/klen/nvim-test/blob/main/lua/nvim-test/runners/pytest.lua
        file_pattern = "\\v(__tests__/.*|test_[^.]+|[^.]+_test|tests)\\.py$",
        find_files = { "__tests__/{name}_test.py", "{name}_test.py", "test_{name}.py",  "tests.py", "tests" },
        filename_modifier = nil,
        working_directory = nil,
      }

      -- TestSuite - run the whole test suite
      -- TestFile - run all tests for the current file
      -- TestEdit - edit tests for the current file
      -- TestNearest - run the test nearest to the cursor
      -- TestLast - rerun the latest test
      -- TestVisit - open the last run test in the current buffer
      -- TestInfo - show an information about the plugin
      vim.keymap.set({ "n" }, "<leader>r", ":TestFile<CR>", opts)
      vim.keymap.set({ "n" }, "<leader>re", ":TestEdit<CR>", opts)
      vim.keymap.set({ "n" }, "<leader>rn", ":TestNearest<CR>", opts)
    end
  },

  -- REPL window
  -- {
  --   'Vigemus/iron.nvim',
  --   config = function()
  --     local iron = require("iron.core")
  --     iron.setup {
  --       config = {
  --         -- Whether a repl should be discarded or not
  --         scratch_repl = true,
  --         -- Your repl definitions come here
  --         repl_definition = {
  --           python = {
  --             command = { "python" },
  --             -- format = require("iron.fts.common").bracketed_paste,
  --           },
  --           sh = {
  --             -- Can be a table or a function that
  --             -- returns a table (see below)
  --             command = {"zsh"}
  --           }
  --         },
  --         -- How the repl window will be displayed
  --         -- See below for more information
  --         repl_open_cmd = require("iron.view").right(90),
  --       },
  --       -- Iron doesn't set keymaps by default anymore.
  --       -- You can set them here or manually add keymaps to the functions in iron.core
  --       keymaps = {
  --         send_motion = "<leader>sc",
  --         visual_send = "<leader>sc",
  --         send_file = "<leader>sf",
  --         send_line = "<leader>sl",
  --         send_paragraph = "<leader>sp",
  --         send_until_cursor = "<leader>su",
  --         send_mark = "<leader>sm",
  --         mark_motion = "<leader>mc",
  --         mark_visual = "<leader>mc",
  --         remove_mark = "<leader>md",
  --         cr = "<leader>s<cr>",
  --         interrupt = "<leader>s<leader>",
  --         exit = "<leader>sq",
  --         clear = "<leader>cl",
  --       },
  --       -- If the highlight is on, you can change how it looks
  --       -- For the available options, check nvim_set_hl
  --       highlight = {
  --         italic = true
  --       },
  --       ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
  --     }
  --
  --     -- iron also has a list of commands, see :h iron-commands for all available commands
  --     vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
  --     vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
  --     vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
  --     vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
  --   end
  -- },

  -- LSP
  -- {
  --   'neoclide/coc.nvim',
  --   branch = 'release',
  -- },

  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = "VeryLazy",
    config = function()
      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      mason_lspconfig.setup({
        ensure_installed = {
          -- "diagnosticls",
          -- "dockerls", "docker_compose_language_service",
          -- "terraformls", "tflint",
          -- "golangci_lint_ls", "gopls",
          -- "kotlin_language_server",
          "jedi_language_server",
          -- "jedi_language_server", "pyre", "pyright", "pylyzer", "pylsp", "ruff_lsp", "sourcery",
          -- "ruby_lsp", "solargraph", "sorbet", "standardrb", "rubocop",
          -- "lua_ls",
          -- "html",
          -- "cssls", "cssmodules_ls", "unocss", "tailwindcss",
          -- "eslint",
          -- "quick_lint_js", "tsserver", "vtsls",  "biome",
          -- "graphql",
          -- "sqlls",
          -- "jsonls",
          "yamlls",
          -- "taplo",
          -- "marksman", "prosemd_lsp", "remark_ls", "vale_ls", "zk",
          -- "vimls",
        },
      })
      -- mason_lspconfig.setup_handlers({
      --   function (server_name) -- default handler (optional)
      --     require("lspconfig")[server_name].setup({
      --       capabilities = capabilities,
      --     })
      --   end,
      -- })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    -- opts = {
    --   inlay_hints = { enabled = true },
    -- },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.jedi_language_server.setup {}
      -- lspconfig.jedi_language_server.setup {
      --   settings = {
      --     jedi = {
      --       codeAction = {
      --         nameExtractVariable = "jls_extract_var",
      --         nameExtractFunction = "jls_extract_def",
      --       },
      --       completion = {
      --         disableSnippets = false,
      --         fuzzy = true,
      --         includeParams = true,
      --         resolveEagerly = true,
      --       },
      --       diagnostics = {
      --         enable = true,
      --       },
      --       hover = {
      --         enable = true,
      --       },
      --       references = {
      --         enable = true,
      --       },
      --       symbols = {
      --         enable = true,
      --       },
      --       workspace = {
      --         extraPaths = {},
      --         symbols = {
      --           ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
      --           maxSymbols = 20,
      --         },
      --       },
      --     }
      --   }
      -- }
    end
  },

  {
    'nvimdev/lspsaga.nvim',
    event = "BufRead",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    config = function()
      require('lspsaga').setup({
        code_action = {
          extend_gitsigns = true,
        },
        finder = {
          max_height = 0.7,
          left_width = 0.3,
          right_width = 0.6,
          keys = {
            shuttle = "<Space>w",
            toggle_or_open = "<CR>"
          }
        },
        lightbulb = {
          enable = false,
        },
      })

      vim.keymap.set('n', 'gr', "<cmd>Lspsaga finder ref+def<CR>", opts)
      vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", opts)
      -- vim.keymap.set({ 'n', 'i' }, '<M-CR>', "<cmd>Lspsaga code_action<CR>", opts)
    end,
  },

  -- Extensible UI for Neovim notifications and LSP progress messages
  {
    "j-hui/fidget.nvim",
    event = "BufRead",
    config = function()
      require("fidget").setup {}
    end
  },

  {
    "folke/trouble.nvim",
    event = "BufRead",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },


  {
    -- 'jose-elias-alvarez/null-ls.nvim',
    'nvimtools/none-ls.nvim',
    event = "BufRead",
    config = function ()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Github action
          -- null_ls.builtins.diagnostics.actionlint,
          -- markdown or txt
          -- null_ls.builtins.diagnostics.textlint,
          -- json/yaml
          -- null_ls.builtins.diagnostics.vacuum,
          -- null_ls.builtins.diagnostics.yamllint,
          -- python
          -- null_ls.builtins.diagnostics.mypy,
          -- print(dump(null_ls.builtins.diagnostics.pylint._opts.command)),
          null_ls.builtins.diagnostics.pylint.with({
            -- print(dump(null_ls.builtins.diagnostics.pylint._opts.command)),
            -- command = vim.fn.system({ "which", "pylint" }),
            diagnostics_postprocess = function(diagnostic)
              diagnostic.code = diagnostic.message_id
            end,
          }),
          -- print(dump(null_ls.builtins.diagnostics.pylint._opts.command)),
          -- null_ls.builtins.formatting.usort,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.black,
          -- null_ls.builtins.formatting.black.with({
          --   extra_args = {"--line-length=120"}
          -- }),
          -- code formatter
          null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.formatting.textlint,
          -- Formatter, linter, bundler, and more for JavaScript, TypeScript, JSON, HTML, Markdown, and CSS.
          -- null_ls.builtins.formatting.biome,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
            local event = "BufWritePre" -- or "BufWritePost"
            local async = event == "BufWritePre"
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = async })
              end,
              desc = "[lsp] format on save",
            })
          end

          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end
        end,
        vim.lsp.buf.format({ timeout_ms = 5000 })
        -- debug = true
      })
    end
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = "BufRead",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function ()
      require("mason-null-ls").setup({
        -- to avoid ensure install pylint ... pylint should use of each project's bin, but using mason cause a problem that mason use own bin rather than project venv's bin.
        -- automatic_installation = true,
      })
    end
  },
}
