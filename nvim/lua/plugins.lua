-- keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

return {
  {
    "williamboman/mason.nvim",
    -- event = "VeryLazy",
    config = function()
      require("mason").setup()
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    -- event = "VeryLazy",
    config = function()
      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- vim.lsp.set_log_level("debug")

      mason_lspconfig.setup({
        ensure_installed = {
          -- "pyright",
          "yamlls",
        },
      })

      mason_lspconfig.setup_handlers({
        function (server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- ["pyright"] = function()
        --   lspconfig.pyright.setup({
        --     capabilities = capabilities,
        --     settings = {
        --       python = {
        --         venvPath = "venv",
        --         pythonPath = "./venv/bin/python",
        --         analysis = {
        --           autoSearchPaths = true,
        --           autoImportCompletions = true,
        --           useLibraryCodeForTypes = true,
        --           typeCheckingMode = "basic",
        --           useImportStrategy = "fromImports",
        --           diagnosticMode = "workspace",
        --           diagnosticSeverityOverrides = {
        --             reportCallIssue = "information",
        --             reportOptionalMemberAccess = "information",
        --             reportOptionalCall = "information",
        --             reportUnknownMemberType = "information",
        --             reportPrivateUsage = "information", 
        --             reportUnknownParameterType = "warning",
        --             reportMissingParameterType = "error",
        --             reportInvalidTypeVarUse = "information",
        --             reportGeneralTypeIssues = "none",
        --             reportUntypedClassDecorator = "information",
        --             reportUnusedImport = "none",
        --             reportUnusedVariable = "none",
        --             reportUnusedClass = "information",
        --             reportReturnType = "warning",
        --             reportUnusedFunction = "information",
        --             reportUnusedCallParameters = "none",
        --           },
        --         }
        --       }
        --     },
        --   })
        -- end,
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },  -- より早い段階でLSPを準備
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
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
        ui = {
          border = 'rounded',        -- ウィンドウの境界線スタイル
          code_action = "💡",        -- コードアクションのアイコン
        },
        hover = {
          max_width = 0.6,          -- ホバーウィンドウの最大幅
          max_height = 0.6,         -- ホバーウィンドウの最大高さ
          open_link = 'gx',         -- リンクを開くキー
          open_cmd = '!chrome'
        },
        diagnostic = {
          show_code_action = true,  -- 診断にコードアクションを表示
          jump_num_shortcut = true, -- ジャンプのショートカット番号を表示
        },
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          extend_gitsigns = true,
        },
        lightbulb = {
          enable = true,
          sign = true,
          debounce = 10,
          virtual_text = true
        },
      })

      -- 診断表示の基本設定
      vim.diagnostic.config({
        virtual_text = {
          source = true,    -- ソースを表示
          prefix = '●',     -- または任意の文字
        },
        float = {
          source = "always",  -- フロートウィンドウでソースを常に表示
          format = function(diagnostic)
            local source = diagnostic.source or "unknown"
            local code = diagnostic.code or ""
            return string.format("[%s:%s] %s", source, code, diagnostic.message)
          end,
        },
        signs = true,
        underline = true,
        severity_sort = true,
      })

      -- 自動ホバー用の設定
      -- vim.opt.updatetime = 100
      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   callback = function()
      --     vim.cmd("Lspsaga hover_doc")
      --   end
      -- })

      -- LSPの基本的なキーマッピングをLspsagaに変更
      vim.keymap.set('n', 'K',  '<cmd>Lspsaga hover_doc<CR>')              -- hover docの表示
      vim.keymap.set('n', 'gf', '<cmd>Lspsaga finder<CR>')                 -- 定義/参照の検索
      vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder ref<CR>')             -- 参照検索
      vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')        -- 定義へジャンプ
      vim.keymap.set('n', 'gi', '<cmd>Lspsaga finder imp<CR>')             -- 実装の検索
      vim.keymap.set('n', 'gt', '<cmd>Lspsaga peek_type_definition<CR>')   -- 型定義のプレビュー
      vim.keymap.set('n', 'gn', '<cmd>Lspsaga rename<CR>')                 -- 名前の変更
      vim.keymap.set('n', 'ga', '<cmd>Lspsaga code_action<CR>')            -- コードアクション
      vim.keymap.set('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')  -- 診断情報の表示
      vim.keymap.set('n', 'g]', '<cmd>Lspsaga diagnostic_jump_next<CR>')   -- 次の診断へジャンプ
      vim.keymap.set('n', 'g[', '<cmd>Lspsaga diagnostic_jump_prev<CR>')   -- 前の診断へジャンプ
      -- 追加の便利な機能
      vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>')         -- アウトライン表示
      vim.keymap.set('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<CR>') -- 呼び出し元を表示
      vim.keymap.set('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<CR>') -- 呼び出し先を表示
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
    -- 'jose-elias-alvarez/null-ls.nvim',
    'nvimtools/none-ls.nvim',
    event = "BufRead",
    config = function ()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- 仮想環境のパスを取得する関数
      local function get_python_tool_path(tool)
        local venv = vim.env.VIRTUAL_ENV
        if venv then
          return venv .. "/bin/" .. tool
        end
        return tool  -- 仮想環境が見つからない場合はツール名をそのまま返す
      end

      null_ls.setup({
        sources = {
          -- python
          null_ls.builtins.diagnostics.pylint.with({
            command = get_python_tool_path("pylint"),
            prefer_local = true,
          }),
          null_ls.builtins.formatting.isort.with({
            command = get_python_tool_path("isort"),
            prefer_local = true,
            extra_args = {"--profile", "black"}
          }),
          null_ls.builtins.formatting.black.with({
            command = get_python_tool_path("black"),
            prefer_local = true,
          }),
          -- markdown or txt
          null_ls.builtins.diagnostics.textlint,
          -- json/yaml
          null_ls.builtins.diagnostics.vacuum,
          null_ls.builtins.diagnostics.yamllint,
          -- code formatter
          null_ls.builtins.formatting.prettier,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
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
        ensure_installed = {
          "isort",
          "usort",
        },
        automatic_installation = true,
      })
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

  -- cmp / completion
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
    },
    config = function()
      local cmp = require('cmp')

      -- VSnip setup
      vim.g.vsnip_filetypes = {
        javascriptreact = {'javascript'},
        typescriptreact = {'typescript'}
      }

      -- Key mappings for vsnip
      local function setup_vsnip_mappings()
        local map = vim.keymap.set
        local opts = {expr = true}

        -- Expand
        map('i', '<C-j>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<C-j>"', opts)
        map('s', '<C-j>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<C-j>"', opts)

        -- Expand or jump
        map('i', '<C-l>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"', opts)
        map('s', '<C-l>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"', opts)

        -- Jump forward or backward
        map('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', opts)
        map('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', opts)
        map('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', opts)
        map('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', opts)

        -- Select or cut text
        map('n', 's', '<Plug>(vsnip-select-text)', {})
        map('x', 's', '<Plug>(vsnip-select-text)', {})
        map('n', 'S', '<Plug>(vsnip-cut-text)', {})
        map('x', 'S', '<Plug>(vsnip-cut-text)', {})
      end

      setup_vsnip_mappings()

      -- nvim-cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            },
          },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
        }, {
            { name = 'path' },
          })
      })

      -- Filetype specific configuration
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
            { name = 'buffer' },
          })
      })

      -- Cmdline configuration
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline(':%s', {
        sources = cmp.config.sources({
          { name = 'buffer' },
          { name = 'path' }
        })
      })
    end
  },

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
    lazy = false,  -- 即時読み込み
    config = function()
      local nvim_tree = require("nvim-tree")

      nvim_tree.setup({
        view = {
          width = 70,
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })

      vim.keymap.set({ "n" }, "<leader>t", ":NvimTreeFindFile<CR>", opts)
      vim.keymap.set({ "n" }, "<leader>tt", ":NvimTreeToggle<CR>", opts)
    end,
  },

  -- syntax provider
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },  -- コマンド実行時のみ読み込み
    config = function()
      local configs = require("nvim-treesitter.configs")
      vim.defer_fn(function()  -- 遅延実行
        configs.setup({
          ensure_installed = { "python", "kotlin", "ruby", "lua", "vim", "sql", "graphql", "json", "yaml", "javascript", "html", "markdown", "markdown_inline"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end, 0)
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
    cmd = { "Telescope" },  -- コマンド実行時のみ読み込み
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          -- sorting_strategy = "descending",
        },
        extensions = {
          frecency = {
            default_workspace = 'CWD', -- 現在のディレクトリに基づいた履歴を表示
            show_scores = true, -- スコアを表示
            show_unindexed = true, -- インデックスされていないファイルも表示
          },
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = { -- extend mappings
              i = {
                ["<C-i>"] = lga_actions.quote_prompt({}),
                -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-space>"] = actions.to_fuzzy_refine,
              },
            },
          }
        },
      })

      local builtin = require('telescope.builtin')
      telescope.load_extension("live_grep_args")

      local function find_files_with_hidden_files()
        builtin.find_files({
          find_command = { "rg", "--files", "--hidden" },
        })
      end

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

      vim.keymap.set('n', '<C-f>', find_files_with_hidden_files, {})
      vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
      vim.keymap.set('n', '<leader>gh', builtin.git_commits, {})
      vim.keymap.set('n', '<leader>ghb', builtin.git_bcommits, {})
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
      vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
      vim.keymap.set('n', '<leader>gst', builtin.git_stash, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      -- あいまい検索
      vim.keymap.set('n', '<C-g>', builtin.grep_string, {})
      -- 完全一致検索
      vim.keymap.set('n', '<C-w>', function()
        builtin.grep_string({ word_match = "-w" })
      end, {})
      vim.keymap.set('n', '<leader>fr', builtin.resume, {})
      vim.keymap.set('n', '<leader>qf', builtin.quickfix, {})
      vim.keymap.set('n', '<leader>qh', builtin.quickfixhistory, {})
      -- vim.keymap.set('n', '<leader>gr', live_grep_file_only, {})
      vim.keymap.set('n', '<leader>gr', function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end, {})
      vim.keymap.set('n', '<leader>grw', function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          additional_args = function()
            return { "--fixed-strings" }
          end
        })
      end, {})
      -- vim.keymap.set('n', '<leader>grn', live_grep_with_line_numbers, {})
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
        },
        extensions = {
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
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function ()
      require('mini.pairs').setup()
    end
  },

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
          width = 150,               -- terminal's width (for vertical|float)
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
      vim.keymap.set({ "n" }, "<leader>ra", ":TestFile<CR>", opts)
      vim.keymap.set({ "n" }, "<leader>re", ":TestEdit<CR>", opts)

      -- Define a function to run TestNearest and then balance windows
      local function test_and_balance()
        vim.cmd(":TestNearest")
        vim.cmd(":wincmd =")
      end

      vim.keymap.set({ "n" }, "<leader>r", test_and_balance, opts)
    end
  },

  {
    "folke/trouble.nvim",
    event = "BufRead",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
