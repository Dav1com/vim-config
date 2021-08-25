" style
set number
set title
set nowrap
set mouse=a
set termguicolors
set background=dark
colorscheme solarized8

" identation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" search
set ignorecase
set smartcase

" spell check
set spelllang=en,es

" movement maps
noremap ñ l
noremap l k
noremap k j
noremap j h
noremap <A-j> ^
noremap <A-ñ> $

" plug
call plug#begin(stdpath('data') . '/plugged')

Plug 'Julian/lean.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'

" Optional Dependencies:

"Plug 'hrsh7th/nvim-compe'  " For LSP completion
"Plug 'hrsh7th/vim-vsnip'   " For snippets
"Plug 'andrewradev/switch.vim'  " For Lean switch support

call plug#end()

" Lua cofig
lua <<EOF
    -- If you don't already have a preferred neovim LSP setup, you may want
    -- to reference the nvim-lspconfig documentation, which can be found at:
    -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
    -- For completeness (of showing this plugin's settings), we show
    -- a barebones LSP attach handler (which will give you Lean LSP
    -- functionality in attached buffers) here:
    local function on_attach(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    end

    require('lean').setup{
      -- Enable the Lean language server(s)?
      --
      -- false to disable, otherwise should be a table of options to pass to
      --  `leanls` and/or `lean3ls`.
      --
      -- See https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#leanls for details.

      -- Lean 4
      lsp = { on_attach = on_attach },

      -- Lean 3
      lsp3 = { on_attach = on_attach },

      -- Abbreviation support
      abbreviations = {
        -- Set one of the following to true to enable abbreviations
        builtin = false, -- built-in expander
        compe = false, -- nvim-compe source
        snippets = false, -- snippets.nvim source
        -- additional abbreviations:
        extra = {
          -- Add a \wknight abbreviation to insert ♘
          --
          -- Note that the backslash is implied, and that you of
          -- course may also use a snippet engine directly to do
          -- this if so desired.
          wknight = '♘',
        },
        -- Change if you don't like the backslash
        -- (comma is a popular choice on French keyboards)
        leader = '\\',
      },

      -- Enable suggested mappings?
      --
      -- false by default, true to enable
      mappings = false,

      -- Infoview support
      infoview = {
        -- Automatically open an infoview on entering a Lean buffer?
        autoopen = true,
        -- Set the infoview windows' widths
        width = 50,
      },

      -- Progress bar support
      progress_bars = {
        -- Enable the progress bars?
        enable = true,
        -- Use a different priority for the signs
        priority = 10,
      },
    }

EOF


