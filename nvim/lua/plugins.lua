-- keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

return {
  -- colorscheme
  --  { 'shaunsingh/nord.nvim',
  --    lazy = false,
  --    priority = 1000,
  --    config = function()
  --      vim.cmd[[colorscheme nord]]
  --
  --      -- Example config in lua
  --      vim.g.nord_contrast = true
  --      vim.g.nord_borders = false
  --      vim.g.nord_disable_background = true
  --      vim.g.nord_italic = false
  --      vim.g.nord_uniform_diff_background = true
  --      vim.g.nord_bold = false
  --
  --      -- Load the colorscheme
  --      require('nord').set()
  --    end
  --  },
  {
    'EdenEast/nightfox.nvim',
    config = function()
      vim.cmd("colorscheme nightfox")
    end
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup()
    end
  },

  -- syntax provider
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
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

  -- textsubjects for nvim-treesitter
  {
    'RRethy/nvim-treesitter-textsubjects',
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

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-f>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
    end
  },

  -- use fzf for telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            -- ripggrepコマンドのオプション
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-uu",
          },
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
    config = function()
      require('telescope').load_extension 'frecency'

      vim.keymap.set('n', '<leader>m', '<Cmd>Telescope frecency<CR>')
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

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Set up lspconfig.
      local lspconfig = require('lspconfig')
      lspconfig.diagnosticls.setup {}
      lspconfig.dockerls.setup {}
      lspconfig.docker_compose_language_service.setup {}
      lspconfig.terraformls.setup {}
      lspconfig.tflint.setup {}
      lspconfig.golangci_lint_ls.setup {}
      lspconfig.gopls.setup {}
      lspconfig.kotlin_language_server.setup {}
      lspconfig.jedi_language_server.setup {}
      -- lspconfig.pyre.setup {}
      lspconfig.pyright.setup {}
      -- lspconfig.sourcery.setup {}
      -- lspconfig.pylsp.setup {}
      -- lspconfig.ruff_lsp.setup {}
      lspconfig.ruby_ls.setup {}
      lspconfig.solargraph.setup {}
      lspconfig.sorbet.setup {}
      lspconfig.standardrb.setup {}
      lspconfig.rubocop.setup {}
      lspconfig.lua_ls.setup {}
      lspconfig.html.setup {}
      lspconfig.cssls.setup {}
      lspconfig.cssmodules_ls.setup {}
      lspconfig.unocss.setup {}
      lspconfig.tailwindcss.setup {}
      lspconfig.eslint.setup {}
      lspconfig.quick_lint_js.setup {}
      lspconfig.tsserver.setup {}
      lspconfig.vtsls.setup {}
      lspconfig.biome.setup {}
      lspconfig.graphql.setup {}
      lspconfig.sqlls.setup {}
      lspconfig.jsonls.setup {}
      lspconfig.yamlls.setup {}
      lspconfig.taplo.setup {}
      lspconfig.marksman.setup {}
      lspconfig.prosemd_lsp.setup {}
      lspconfig.remark_ls.setup {}
      lspconfig.vale_ls.setup {}
      lspconfig.zk.setup {}
      lspconfig.vimls.setup {}
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "diagnosticls",
          "dockerls", "docker_compose_language_service",
          "terraformls", "tflint",
          "golangci_lint_ls", "gopls",
          "kotlin_language_server",
          "jedi_language_server", "pyre", "pyright", "pylyzer", "sourcery", "pylsp", "ruff_lsp",
          "ruby_ls", "solargraph", "sorbet", "standardrb", "rubocop",
          "lua_ls",
          "html",
          "cssls", "cssmodules_ls", "unocss", "tailwindcss",
          "eslint",
          "quick_lint_js", "tsserver", "vtsls",  "biome",
          "graphql",
          "sqlls",
          "jsonls",
          "yamlls",
          "taplo",
          "marksman", "prosemd_lsp", "remark_ls", "vale_ls", "zk",
          "vimls",
        },
      }
    end
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    config = function()
    end
  },
  {
    'hrsh7th/cmp-buffer',
    config = function()
    end
  },
  {
    'hrsh7th/cmp-path',
    config = function()
    end
  },
  {
    'hrsh7th/cmp-cmdline',
    config = function()
    end
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      -- Set up nvim-cmp.
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
            { name = 'buffer' },
          })
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
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          })
      })
    end
  },
  {
    'hrsh7th/cmp-vsnip',
    config = function()
    end
  },
  {
    'hrsh7th/vim-vsnip',
    config = function()
    end
  },

  -- Extensible UI for Neovim notifications and LSP progress messages
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
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

  -- TODO: deprecated
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function ()
      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
      local event = "BufWritePre" -- or "BufWritePost"
      local async = event == "BufWritePost"

      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
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
      })
    end
  },

  -- formatter
  {
    'MunifTanjim/prettier.nvim',
    config = function ()
      local prettier = require("prettier")

      prettier.setup({
        bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
        filetypes = {
          "css",
          "graphql",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "markdown",
          "scss",
          "typescript",
          "typescriptreact",
          "yaml",
        },
      })
    end
  },

  -- removes trailing white space and empty lines on BufWritePre
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },

  -- mkdir
  {
    'jghauser/mkdir.nvim'
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
      keymap("i", "R", "<Plug>(operator-replace)", opts)
    end
  },

  -- Comment
  {
    'echasnovski/mini.comment',
    version = '*',
    config = function ()
      require('mini.comment').setup()
    end
  },

  -- surround
  {
    'echasnovski/mini.surround',
    version = '*',
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
  }
}
