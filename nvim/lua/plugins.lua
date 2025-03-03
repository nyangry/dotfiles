-- keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.keymap.set

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
        -- ensure_installed = {
        --   "pyright",
        --   "pylsp",
        --   "yamlls",
        -- },
      })

      mason_lspconfig.setup_handlers({
        function (server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
              python = {
                venvPath = "venv",
                pythonPath = "./venv/bin/python",
                analysis = {
                  autoSearchPaths = true,
                  autoImportCompletions = true,
                  useLibraryCodeForTypes = true,
                  typeCheckingMode = "off",
                  useImportStrategy = "fromImports",
                  diagnosticMode = "workspace",
                  -- diagnosticSeverityOverrides = {
                  --   reportCallIssue = "information",
                  --   reportOptionalMemberAccess = "information",
                  --   reportOptionalCall = "information",
                  --   reportUnknownMemberType = "information",
                  --   reportPrivateUsage = "information", 
                  --   reportUnknownParameterType = "warning",
                  --   reportMissingParameterType = "error",
                  --   reportInvalidTypeVarUse = "information",
                  --   reportGeneralTypeIssues = "none",
                  --   reportUntypedClassDecorator = "information",
                  --   reportUnusedImport = "none",
                  --   reportUnusedVariable = "none",
                  --   reportUnusedClass = "information",
                  --   reportReturnType = "warning",
                  --   reportUnusedFunction = "information",
                  --   reportUnusedCallParameters = "none",
                  -- },
                }
              }
            },
          })
        end,
        ["pylsp"] = function()
          lspconfig.pylsp.setup({
            capabilities = capabilities,
            settings = {
              pylsp = {
                plugins = {
                  rope_completion = { enabled = true },
                  rope_autoimport = { enabled = true },
                  rope_rename = { enabled = true },
                  rope_refactor = { enabled = true },
                  definition = { enabled = true },
                  references = { enabled = true },
                  signature = { enabled = true },
                  symbols = { enabled = true },
                  preload_imports = { enabled = true },
                  pycodestyle = { enabled = false },
                  mccabe = { enabled = false },
                  pyflakes = { enabled = false },
                  pylint = { enabled = false },
                  yapf = { enabled = false },
                  autopep8 = { enabled = false },
                  flake8 = { enabled = false },
                  jedi_completion = { enabled = false },
                  jedi_hover = { enabled = false },
                  jedi_references = { enabled = false },
                  jedi_signature_help = { enabled = false },
                  jedi_symbols = { enabled = false },
                }
              }
            }
          })
        end,
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
    end
  },

  {
    'nvimdev/lspsaga.nvim',
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
          debounce = 5000,
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
      keymap('n', 'K',  '<cmd>Lspsaga hover_doc<CR>')              -- hover docの表示
      keymap('n', 'gf', '<cmd>Lspsaga finder<CR>')                 -- 定義/参照の検索
      keymap('n', 'gr', '<cmd>Lspsaga finder ref<CR>')             -- 参照検索
      keymap('n', 'gi', '<cmd>Lspsaga finder imp<CR>')             -- 実装の検索
      keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')        -- 定義へジャンプ
      keymap('n', 'gdt', '<cmd>Lspsaga peek_type_definition<CR>')   -- 型定義のプレビュー
      -- keymap('n', 'gn', '<cmd>Lspsaga rename<CR>')                 -- 名前の変更
      keymap('n', 'ga', '<cmd>Lspsaga code_action<CR>')            -- コードアクション
      keymap('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')  -- 診断情報の表示
      keymap('n', 'g]', '<cmd>Lspsaga diagnostic_jump_next<CR>')   -- 次の診断へジャンプ
      keymap('n', 'g[', '<cmd>Lspsaga diagnostic_jump_prev<CR>')   -- 前の診断へジャンプ
      -- 追加の便利な機能
      keymap('n', '<leader>o', '<cmd>Lspsaga outline<CR>')         -- アウトライン表示
      keymap('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<CR>') -- 呼び出し元を表示
      keymap('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<CR>') -- 呼び出し先を表示
    end,
  },

  -- Extensible UI for Neovim notifications and LSP progress messages
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end
  },

  {
    -- 'jose-elias-alvarez/null-ls.nvim',
    'nvimtools/none-ls.nvim',
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
          -- null_ls.builtins.diagnostics.vacuum,
          -- null_ls.builtins.diagnostics.yamllint.with({
          --   extra_args = {
          --     "-d", "{extends: default, rules: {line-length: disable}}"
          --   }
          -- }),
          -- code actions
          null_ls.builtins.code_actions.refactoring,
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
            keymap("x", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end

          -- diagnosticsの自動実行設定
          local group = vim.api.nvim_create_augroup("lsp_diagnostics_refresh", { clear = false })

          -- バッファ移動時
          vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.diagnostic.show()
            end,
          })

          local timer = vim.loop.new_timer()
          timer:start(0, 5000, vim.schedule_wrap(function()
            if vim.api.nvim_buf_is_valid(bufnr) then
              vim.diagnostic.show()
            end
          end))
        end,
        vim.lsp.buf.format({ timeout_ms = 5000 })
      })
    end
  },

  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function ()
      require("mason-null-ls").setup({
        -- to avoid ensure install pylint ... pylint should use of each project's bin, but using mason cause a problem that mason use own bin rather than project venv's bin.
        -- ensure_installed = {
        --   "isort",
        --   "yamllint",
        -- },
        -- automatic_installation = true,
      })
    end
  },

  -- It allows you to quickly select, yank, delete or replace language-specific ranges.
  {
    'David-Kunz/treesitter-unit',
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
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')

      -- nvim-cmp setup
      cmp.setup({
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
    lazy = true,
    cmd = { 'NvimTreeFindFile', 'NvimTreeToggle', 'NvimTreeOpen' }, 
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

      keymap("n", ",f", ":NvimTreeFindFile<CR>", opts)
      keymap("n", ",ft", ":NvimTreeToggle<CR>", opts)
    end,
  },

  -- syntax provider
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        -- ensure_installed = { 
        --   "python", "kotlin", "ruby", "lua", "vim", 
        --   "sql", "graphql", "json", "yaml", 
        --   "javascript", "typescript", "html", 
        --   "markdown", "markdown_inline"
        -- },
        sync_install = false,
        auto_install = false, -- 自動インストールを無効化
        highlight = { 
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>", -- set to `false` to disable one of the mappings
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
        indent = { enable = true },
      })
    end,
    init = function()
      -- runtimepathの最適化
      vim.opt.runtimepath:remove("/usr/share/nvim/runtime/parser")
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser")
    end,
  },

  -- context support for nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
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

  -- textobjects for nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter-textobjects', 
    config = function ()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = false,
          },
        },
      }
    end
  }, 

  -- code outline window
  {
    'stevearc/aerial.nvim',
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "AerialPrev", "AerialNext", "AerialToggle" },
    keys = { 
      { ",a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      on_attach = function(bufnr)
        keymap("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial Previous" })
        keymap("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial Next" })
        keymap("n", "%", function()
          -- カーソル下の文字が括弧系なら従来の%機能を使用
          local char = vim.fn.getline("."):sub(vim.fn.col("."), vim.fn.col("."))
          if char:match("[%(%{%[%]%}%)]") then
            vim.cmd("normal! %")
          else
            -- そうでなければ関数全体を選択
            require("nvim-treesitter.textobjects.select").select_textobject("@function.outer", "visual")
          end
        end, { desc = "Smart % - match brackets or select function" })
      end,
    },
  }, 

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    lazy = true, 
    cmd = { "Telescope" },
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

      keymap('n', '<C-f>', find_files_with_hidden_files, {})
      keymap('n', '<leader>tgf', builtin.git_files, {})
      keymap('n', '<leader>tgh', builtin.git_commits, {})
      keymap('n', '<leader>tghb', builtin.git_bcommits, {})
      keymap('n', '<leader>tgb', builtin.git_branches, {})
      keymap('n', '<leader>tgs', builtin.git_status, {})
      keymap('n', '<leader>tgst', builtin.git_stash, {})
      keymap('n', '<leader>tb', builtin.buffers, {})
      -- あいまい検索
      keymap('n', '<C-g>', builtin.grep_string, {})
      -- 完全一致検索
      -- keymap('n', '<C-w>', function()
      --   builtin.grep_string({ word_match = "-w" })
      -- end, {})
      -- keymap('n', '<leader>fr', builtin.resume, {})
      keymap('n', '<leader>tqf', builtin.quickfix, {})
      keymap('n', '<leader>tqh', builtin.quickfixhistory, {})
      -- keymap('n', '<leader>gr', live_grep_file_only, {})
      keymap('n', '<leader>tr', function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end, {})
      keymap('n', '<leader>trw', function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          additional_args = function()
            return { "--fixed-strings" }
          end
        })
      end, {})
    end
  },

  -- use fzf for telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
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
    config = function()
      require('telescope').load_extension 'frecency'

      keymap('n', '<leader>m', '<Cmd>Telescope frecency workspace=CWD<CR>', opts)
    end,
  },

  -- file browser extension for telescope
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension "file_browser"
    end
  },

  -- toggleterm
  {
    'akinsho/toggleterm.nvim', 
    lazy = true,
    cmd = { "ToggleTerm" }, 
    keys = { -- キーマッピングで読み込みをトリガー
      { ",th", "<cmd>1ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
      { ",tv", "<cmd>1ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
      { ",tt", "<cmd>1ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    config = function()
      require('toggleterm').setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 30
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        direction = 'horizontal', -- 'vertical' | 'horizontal' | 'float'
        start_in_insert = true,       -- 開いた時にインサートモードに
        insert_mappings = true,       -- インサートモードでのマッピングを有効
        terminal_mappings = true,     -- ターミナルモードでのマッピングを有効
        persist_size = true,          -- サイズを記憶
        persist_mode = true,          -- モードを記憶
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          winblend = 3,
        }
      })

      keymap('n', ',th', '<cmd>1ToggleTerm direction=horizontal<cr>')
      keymap('n', ',tv', '<cmd>1ToggleTerm direction=vertical<cr>')
      keymap('n', ',tt', '<cmd>1ToggleTerm<cr>')
      function _G.set_terminal_keymaps()
        -- ノーマルモードへの切り替え
        keymap('t', '<esc>', [[<C-\><C-n>]], opts)
        -- ウィンドウ移動
        keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
      -- ターミナルバッファを開いた時に設定を適用
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
        end,
      })
    end
  }, 

  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { ",g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }, 

  -- git sign
  {
    'lewis6991/gitsigns.nvim',
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
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 1000,
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
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          -- Navigation
          keymap('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          keymap('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          keymap('n', '<leader>ghs', gitsigns.stage_hunk)
          keymap('n', '<leader>ghr', gitsigns.reset_hunk)

          keymap('v', '<leader>ghs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          keymap('v', '<leader>ghr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          keymap('n', '<leader>ghS', gitsigns.stage_buffer)
          keymap('n', '<leader>ghR', gitsigns.reset_buffer)
          keymap('n', '<leader>ghp', gitsigns.preview_hunk)
          keymap('n', '<leader>ghi', gitsigns.preview_hunk_inline)

          keymap('n', '<leader>gb', function()
            gitsigns.blame_line({ full = true })
          end)

          keymap('n', '<leader>gd', gitsigns.diffthis)

          keymap('n', '<leader>gD', function()
            gitsigns.diffthis('~')
          end)

          keymap('n', '<leader>gQ', function() gitsigns.setqflist('all') end)
          keymap('n', '<leader>gq', gitsigns.setqflist)

          -- Toggles
          keymap('n', '<leader>gtb', gitsigns.toggle_current_line_blame)
          keymap('n', '<leader>gtd', gitsigns.toggle_deleted)
          keymap('n', '<leader>gtw', gitsigns.toggle_word_diff)

          -- Text object
          keymap({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }

      vim.api.nvim_set_hl(0, "MyCustomBlame", {
        fg = "#fefdd9",
        bg = "NONE",
        italic = true,
      })
      vim.cmd("highlight clear GitSignsCurrentLineBlame")
      vim.cmd("highlight link GitSignsCurrentLineBlame MyCustomBlame")
    end
  },

  --  indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function ()
      local ibl = require("ibl")
      ibl.setup()
    end
  },

  -- removes trailing white space and empty lines on BufWritePre
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },

  -- mkdir
  {
    'jghauser/mkdir.nvim',
  },

  -- highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  {
    'RRethy/vim-illuminate',
    config = function ()
    end
  },

  -- A high-performance color highlighter for Neovim
  {
    'norcalli/nvim-colorizer.lua',
    config = function ()
      require'colorizer'.setup()
    end
  },

  -- Operator
  {
    'kana/vim-operator-replace',
    dependencies = { 'kana/vim-operator-user' },
    config = function()
      keymap("n", "R", "<Plug>(operator-replace)", opts)
      keymap("v", "R", "<Plug>(operator-replace)", opts)
      -- keymap("i", "R", "<Plug>(operator-replace)", opts)
    end
  },

  -- keyword Jump
  {
    'echasnovski/mini.jump',
    config = function()
      local mini_jump = require('mini.jump')
      mini_jump.setup({
        mappings = {
          forward = 'f',
          backward = 'F',
          forward_till = '',
          backward_till = '',
          repeat_jump = '',
        },

      })
    end
  },

  -- Comment
  {
    'echasnovski/mini.comment',
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
    config = function ()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group{
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.constant.new({ elements = {"True", "False"}, word = true }),
          augend.date.alias["%Y/%m/%d"],
        },
      }
      keymap("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      keymap("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
    end
  },

  -- yankring
  {
    "gbprod/yanky.nvim",
    opts = {},
    config = function ()
      keymap("n", "<C-p>", "<Plug>(YankyPreviousEntry)", opts)
      keymap("n", "<C-n>", "<Plug>(YankyNextEntry)", opts)
    end
  },

  -- translate
  {
    'uga-rosa/translate.nvim',
    lazy = true,
    cmd = { 'Translate' }, 
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

      keymap("n", "<C-e>", ":<C-u>Translate EN<CR>", opts)
      -- keymap("n", "<C-j>", ":<C-u>Translate JA<CR>", opts)
      keymap("n", "<space>te", ":<C-u>Translate EN<CR>", opts)
      keymap("n", "<space>tj", ":<C-u>Translate JA<CR>", opts)
      keymap("n", "<space>tei", ":<C-u>Translate EN -output=insert<CR>", opts)
      keymap("n", "<space>tji", ":<C-u>Translate JA -output=insert<CR>", opts)
      keymap("v", "<space>te", ":Translate EN<CR>", opts)
      keymap("v", "<space>tj", ":Translate JA<CR>", opts)
      keymap("v", "<space>tei", ":Translate EN -output=insert<CR>", opts)
      keymap("v", "<space>tji", ":Translate JA -output=insert<CR>", opts)
    end
  },

  -- test runner
  {
    "klen/nvim-test",
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
      keymap("n", "<leader>ra", ":TestFile<CR>", opts)
      keymap("n", "<leader>re", ":TestEdit<CR>", opts)

      -- Define a function to run TestNearest and then balance windows
      local function test_and_balance()
        vim.cmd(":TestNearest")
        vim.cmd(":wincmd =")
      end

      keymap("n", "<leader>r", test_and_balance, opts)
    end
  },

  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = true, 
    keys = { -- キーマッピングで読み込みをトリガー
      { "<leader>S", function() require("spectre").toggle() end, desc = "Toggle Spectre" },
      { "<leader>sw", function() require("spectre").open_visual({select_word=true}) end, mode = "n", desc = "Search current word" },
      { "<leader>sw", function() require("spectre").open_visual() end, mode = "v", desc = "Search current word" },
      { "<leader>sp", function() require("spectre").open_file_search({select_word=true}) end, desc = "Search on current file" },
    },
    config = function()
      require('spectre').setup({
        color_devicons = true,
        open_cmd = 'vnew', -- can also be a lua function
        live_update = false, -- auto execute search again when you write to any file in vim
        lnum_for_results = true, -- show line number for search/replace results
        line_sep_start = '┌-----------------------------------------',
        result_padding = '¦  ',
        line_sep       = '└-----------------------------------------',
        highlight = {
          ui = "String",
          search = "Search",
          replace = "CurSearch"
        },
        find_engine = {
          ['rg'] = {
            cmd = "rg",
            args = {
              '--case-sensitive',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
            },
            options = {
              ['ignore-case'] = {
                value= "--ignore-case",
                icon="[I]",
                desc="ignore case"
              },
              ['hidden'] = {
                value="--hidden",
                desc="hidden file",
                icon="[H]"
              },
            }
          }
        }, 
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = {
              "-i",
              "",
              "-E",
            },
          },
        },
      })
      keymap('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = "Toggle Spectre"
      })
      keymap('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = "Search current word"
      })
      keymap('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = "Search current word"
      })
      keymap('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = "Search on current file"
      })
    end,
  },
}
