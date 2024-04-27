vim.loader.enable()

-- options
local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  title = true,
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 300,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  shell = "zsh",
  backupskip = { "/tmp/*", "/private/tmp/*" },
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = false,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false,
  winblend = 0,
  wildoptions = "pum",
  pumblend = 5,
  background = "dark",
  scrolloff = 8,
  sidescrolloff = 8,
  splitbelow = true,
  splitright = true,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")



vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap


-- file delete
keymap("n", ",fd", ":call delete(expand('%'))<CR>", opts)
--

keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
-- keymap("n", "+", "<C-a>", opts)
-- keymap("n", "-", "<C-x>", opts)

keymap("n", "Y", "y$", opts)

-- http:/qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca/
keymap("n", "s", "<Nop>", opts)
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sl", "<C-w>l", opts)
keymap("n", "sH", "<C-w>H", opts)
keymap("n", "sJ", "<C-w>J", opts)
keymap("n", "sK", "<C-w>k", opts)
keymap("n", "sL", "<C-w>L", opts)
keymap("n", "sn", "gt", opts)
keymap("n", "sp", "gT", opts)
keymap("n", "th", ":tabmove -1<CR>", opts)
keymap("n", "tl", ":tabmove +1<CR>", opts)
keymap("n", "tc", ":tabclose<CR>", opts)
keymap("n", "sO", "<C-w>=", opts)
keymap("n", "st", ":<C-u>tabnew<CR>", opts)
keymap("n", "ss", ":<C-u>sp<CR>", opts)
keymap("n", "sv", ":<C-u>vs<CR>", opts)
keymap("n", "<silent> j", "gj", opts)
keymap("n", "<silent> k", "gk", opts)

-- Escの2回押しでハイライト消去
keymap("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>", opts)

-- 強制終了
keymap("n", "<C-q><C-q>", ":qa!<CR>", opts)
keymap("v", "<C-q><C-q>", ":qa!<CR>", opts)
keymap("i", "<C-q><C-q>", ":qa!<CR>", opts)

-- redraw!
keymap("n", "<leader>w", ":redraw!<CR>", opts)

-- ビジュアルモードで選択したテキストで検索する
-- keymap("v", "<silent> *", '"vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>', opts)

-- ヤンク、ペースト後のカーソル移動
keymap("v", "<silent> y", "y`]", opts)
keymap("v", "<silent> p", "p`]", opts)
keymap("n", "<silent> p", "p`]", opts)

-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- コンマの後に自動的にスペースを挿入
keymap("i", ",", ",<Space>", opts)

-- 画面移動
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)
keymap("n", "<c-left>", "<c-w>h", opts)
keymap("n", "<c-down>", "<c-w>j", opts)
keymap("n", "<c-up>", "<c-w>k", opts)
keymap("n", "<c-right>", "<c-w>l", opts)

-- c*でカーソル下のキーワードを置換
-- http://miniman2011.blog55.fc2.com/blog-entry-295.html
keymap("n", "c*", [[':%s ;\<' . expand('<cword>') . '\>;']], { expr = true })
keymap("v", "c*", [[':s ;\<' . expand('<cword>') . '\>;']], { expr = true })


-- autocmds
-- タブ幅をリセット (効いてない？)
-- vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
--   pattern = '*',
--   callback = function()
--     vim.api.nvim_buf_set_option(0, 'tabstop', 2)
--     vim.api.nvim_buf_set_option(0, 'shiftwidth', 2)
--   end,
-- })
