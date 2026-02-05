--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

-- Plugins will be downloaded under the specified directory.
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

-- Declare the list of plugins.

-- Plugin for Git support.
-- Plug 'tpope/vim-fugitive.vim'


Plug('junegunn/fzf', { ['do'] = ':call fzf#install()' })
Plug('junegunn/fzf.vim')

-- Plugin for converting variables/words from various letter cases.
Plug('tpope/vim-abolish')

-- Plugin for commenting code.
Plug('tpope/vim-commentary')

-- Plugin for argument text objects.
Plug('vim-scripts/argtextobj.vim')

Plug('justinmk/vim-sneak')

-- Color schemes.
Plug('joshdick/onedark.vim')

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

Plug('preservim/nerdtree')
Plug('Xuyuanp/nerdtree-git-plugin')

Plug('mfussenegger/nvim-jdtls')

-- Support for Clojure.  (Note: Some commands in vim-fireplace conflict with coc, so you need to not use coc).
Plug('tpope/vim-fireplace')

-- vim-sexp must load before vim-sexp-mappings-for-regular-people.
Plug('guns/vim-sexp')
Plug('tpope/vim-sexp-mappings-for-regular-people')


Plug('tpope/vim-repeat')
Plug('tpope/vim-surround')

-- LSP Support.
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

-- Autocompletion.
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')


-- List ends here. Plugins become visible to Vim after this call.
vim.call('plug#end')


--------------------------------------------------------------------------------
-- General settings.
--------------------------------------------------------------------------------

-- Turn on line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabbing
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

-- Smart case searching.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable usage of the mouse.
vim.opt.mouse = 'a'


-- Clipboard functionality.
vim.opt.clipboard:append('unnamedplus')
-- vim.opt.clipboard = 'unnamedplus'
-- vim.keymap.set('', '<Leader>y', '"+y')

--------------------------------------------------------------------------------
-- Sneak plugin settings.
--------------------------------------------------------------------------------
vim.keymap.set('', 'f', '<Plug>Sneak_f')
vim.keymap.set('', 'F', '<Plug>Sneak_F')
vim.keymap.set('', 't', '<Plug>Sneak_t')
vim.keymap.set('', 'T', '<Plug>Sneak_T')

--------------------------------------------------------------------------------
-- Color Scheme Settings
--------------------------------------------------------------------------------
vim.cmd('syntax on')

-- Color Scheme.
--
-- Credit joshdick
-- Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
-- If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
-- (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if vim.fn.empty(vim.env.TMUX) == 1 then
  if vim.fn.has('nvim') == 1 then
    -- For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = '1'
  end
  -- For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  -- Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  -- < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
  end
end

-- onedark.vim override: Don't set a background color when running in a terminal;
-- just use the terminal's background color
-- `gui` is the hex color code used in GUI mode/nvim true-color mode
-- `cterm` is the color code used in 256-color mode
-- `cterm16` is the color code used in 16-color mode
if vim.fn.has('autocmd') == 1 and vim.fn.has('gui_running') == 0 then
  local colorset_group = vim.api.nvim_create_augroup('colorset', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = colorset_group,
    pattern = '*',
    callback = function()
      local white = { gui = '#ABB2BF', cterm = '145', cterm16 = '7' }
      vim.fn['onedark#set_highlight']('Normal', { fg = white })
    end,
  })
end

vim.cmd('colorscheme onedark')

-- Airline settings.
vim.g['airline#extensions#tabline#enabled'] = 1

--------------------------------------------------------------------------------
-- Aliases for Vim plugin fzf.vim
--------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>g', ':Rg<CR>')
vim.keymap.set('n', '<leader>fi', ':Files<CR>')
vim.keymap.set('n', '<leader>b', ':Buffers<CR>')


--------------------------------------------------------------------------------
-- Config for NERDTree plugin.
--------------------------------------------------------------------------------

vim.keymap.set('', '<C-n>', ':NERDTreeToggle<CR>')
vim.keymap.set('', '<leader>n', ':NERDTreeFind<CR>')

------------------------------------------------------------------------------
-- Paste the current date and time in ISO8601 format.
------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>d", ":call Date()<CR>", {})

------------------------------------------------------------------------------
-- Manipulating buffers.
------------------------------------------------------------------------------

-- Buffer delete all.
vim.api.nvim_set_keymap("n", "<leader>bda", ":%bd<CR>", {})

-- Buffer delete others.
-- This will return the cursor back to where it was.
vim.api.nvim_set_keymap("n", "<leader>bdo", ':%bd|execute "normal <C-O>"|bd#<CR>', {})

-- Buffer delete this.
vim.api.nvim_set_keymap("n", "<leader>bdt", ":bd<CR>", {})

------------------------------------------------------------------------------
-- Copy current file name (relative/absolute) to system clipboard
------------------------------------------------------------------------------

-- Copy current file name (relative/absolute) to system clipboard (Mac version).
if (vim.fn.has("mac") == 1 or
    vim.fn.has("gui_macvim") == 1 or
    vim.fn.has("gui_mac") == 1) then

    -- relative path  (src/foo.txt)
    vim.api.nvim_set_keymap("n", "<leader>cf",  ':let @*=expand("%")<CR>', {noremap = true})

    -- absolute path  (/something/src/foo.txt)
    vim.api.nvim_set_keymap("n", "<leader>cF",  ':let @*=expand("%:p")<CR>', {noremap = true})

    -- filename       (foo.txt)
    vim.api.nvim_set_keymap("n", "<leader>ct",  ':let @*=expand("%:t")<CR>', {noremap = true})

    -- directory name (/something/src)
    vim.api.nvim_set_keymap("n", "<leader>ch",  ':let @*=expand("%:p:h")<CR>', {noremap = true})
end

-- Copy current file name (relative/absolute) to system clipboard (Linux version).
if (vim.fn.has("gui_gtk") == 1 or
    vim.fn.has("gui_gtk2") == 1 or
    vim.fn.has("gui_gnome") == 1 or
    vim.fn.has("unix") == 1 ) then

    -- relative path  (src/foo.txt)
    vim.api.nvim_set_keymap("n", "<leader>cf",  ':let @+=expand("%")<CR>', {noremap = true})

    -- absolute path  (/something/src/foo.txt)
    vim.api.nvim_set_keymap("n", "<leader>cF",  ':let @+=expand("%:p")<CR>', {noremap = true})

    -- filename       (foo.txt)
    vim.api.nvim_set_keymap("n", "<leader>ct",  ':let @+=expand("%:t")<CR>', {noremap = true})

    -- directory name (/something/src)
    vim.api.nvim_set_keymap("n", "<leader>ch",  ':let @+=expand("%:p:h")<CR>', {noremap = true})
end

--------------------------------------------------------------------------------
-- Custom config for tpope/vim-sexp-mappings-for-regular-people
--------------------------------------------------------------------------------

vim.g.sexp_no_word_maps = 1


--------------------------------------------------------------------------------
-- Custom command to format the current buffer containing JSON into pretty
-- indented output.
--------------------------------------------------------------------------------

vim.api.nvim_create_user_command('JsonPrettify', '%!python -m json.tool', {})

--------------------------------------------------------------------------------
-- Remove all trailing whitespace
--------------------------------------------------------------------------------

-- Solution was adapted from:
-- http://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
vim.cmd(
    [[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    ]])
vim.cmd('command! TrimWhitespace call TrimWhitespace()')

-- function TrimWhitespace()
--   local save = vim.fn.winsaveview()
--   vim.cmd([[%s/\s\+$//e]])
--   vim.fn.winrestview(save)
-- end

--------------------------------------------------------------------------------
-- Paste the current date and time in ISO8601 format.
--------------------------------------------------------------------------------

vim.cmd(
    [==[
    fun! Date()
        let format = '+%Y-%m-%dT%H:%M:%SZ'
        let cmd = '/bin/date -u ' . shellescape(format)
        let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
        call setline(line('.'), getline('.') . result)
    endfun
    ]==])
vim.cmd('command! Date call Date()')

--function Date()
--    local format = '+%Y-%m-%dT%H:%M:%SZ'
--    local cmd = '/bin/date -u ' .. vim.fn.shellescape(format)
--    local result = vim.fn.system(cmd):gsub('[\n\r]', '')
--    local line = vim.fn.line('.')
--    vim.fn.setline(line, vim.fn.getline('.') .. result)
--end
--vim.api.nvim_create_user_command('Date', Date, {})

--------------------------------------------------------------------------------
-- LSP Configuration
--------------------------------------------------------------------------------

-- Setup Mason for automatic LSP server installation.
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',        -- Python
    'jdtls',          -- Java (used via nvim-jdtls, not lspconfig)
    'ts_ls',          -- TypeScript/JavaScript
    'lua_ls',         -- Lua
    'rust_analyzer',  -- Rust
    'gopls',          -- Go
    'clangd',         -- C/C++
    'bashls',         -- Bash
    'html',           -- HTML
    'cssls',          -- CSS
    'jsonls',         -- JSON
  },
})

--------------------------------------------------------------------------------
-- Autocompletion (nvim-cmp)
--------------------------------------------------------------------------------

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

--------------------------------------------------------------------------------
-- LSP Keybindings and Server Setup (Neovim 0.11+ API)
--------------------------------------------------------------------------------

-- LSP keybindings: applied automatically when any LSP attaches to a buffer.
-- This replaces the old on_attach pattern and works for all LSP servers,
-- including jdtls.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>fm', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Global LSP capabilities (enhanced with nvim-cmp), applied to all servers.
vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Python
vim.lsp.config('pyright', {})

-- TypeScript / JavaScript
vim.lsp.config('ts_ls', {})

-- Lua
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- Rust
vim.lsp.config('rust_analyzer', {})

-- Go
vim.lsp.config('gopls', {})

-- C / C++
vim.lsp.config('clangd', {})

-- Bash
vim.lsp.config('bashls', {})

-- HTML
vim.lsp.config('html', {})

-- CSS
vim.lsp.config('cssls', {})

-- JSON
vim.lsp.config('jsonls', {})

-- Enable all LSP servers.
vim.lsp.enable({
  'pyright', 'ts_ls', 'lua_ls', 'rust_analyzer', 'gopls',
  'clangd', 'bashls', 'html', 'cssls', 'jsonls',
})

-- Global diagnostic keybindings.
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap = true, silent = true })

--------------------------------------------------------------------------------
-- Java LSP (jdtls) Configuration
--
-- Uses the nvim-jdtls plugin (mfussenegger/nvim-jdtls) instead of vim.lsp.config.
-- Mason installs the jdtls binary; nvim-jdtls manages the server lifecycle.
-- Each project gets its own workspace data directory.
-- Keybindings are set automatically via the LspAttach autocmd above.
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

    local root_markers = vim.fs.find(
      { 'gradlew', 'pom.xml', 'mvnw', 'build.gradle', '.git' },
      { upward = true }
    )
    local root_dir = root_markers[1] and vim.fs.dirname(root_markers[1]) or vim.fn.getcwd()

    require('jdtls').start_or_attach({
      cmd = { 'jdtls', '-data', workspace_dir },
      root_dir = root_dir,
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = 'fernflower' },
          completion = {
            favoriteStaticMembers = {
              'org.hamcrest.MatcherAssert.assertThat',
              'org.hamcrest.Matchers.*',
              'org.hamcrest.CoreMatchers.*',
              'org.junit.jupiter.api.Assertions.*',
              'java.util.Objects.requireNonNull',
              'java.util.Objects.requireNonNullElse',
              'org.mockito.Mockito.*',
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },
    })
  end,
})

--------------------------------------------------------------------------------

-- claude.vim Configuration
-- https://github.com/pasky/claude.vim
--
-- local claude_api_key = os.getenv("CLAUDE_API_KEY")
-- 
-- -- Check if the environment variable was found and is not empty
-- if claude_api_key and claude_api_key ~= "" then
--     vim.g.claude_api_key = claude_api_key
-- else
--     -- Log an error or warning if the key is missing
--     vim.api.nvim_err_writeln("Error: CLAUDE_API_KEY environment variable not set or is empty.")
-- end

