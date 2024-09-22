
"""""""""""
" OPTIONS "
"""""""""""
set clipboard+=unnamed
set clipboard+=unnamedplus " Allows Vim to access the system clipboard
set hlsearch " Highlight all matches on the previous search pattern
set mouse=a " Allow the mouse to be used in all modes
set noshowmode " Don't show mode like -- INSERT --
set incsearch " Incremental search: search as characters are entered
set nohlsearch " Disable search highlighting after search is complete
set ignorecase " Ignore case in searches by default
set smartcase " Override ignorecase if search contains uppercase letters
set noswapfile " Disable swapfile creation
set termguicolors " Enable 24-bit RGB colors in the terminal (true colors)
set timeoutlen=500 " Set time to wait for a mapped sequence to complete (in milliseconds)
set updatetime=300 " Faster update time (default is 4000ms)
set cursorline " Highlight the current line
set numberwidth=2 " Set number column width to 2 (default is 4)
set signcolumn=no " Always show the sign column, even if there are no signs
set tabstop=4 " Set the number of spaces a tab counts for
set softtabstop=4 " Set the number of spaces a tab counts for
set shiftwidth=4 " Set the number of spaces inserted for each indentation
set expandtab " Convert tabs to spaces
set wrap " Enable line wrapping
set scrolloff=8 " Set minimum number of screen lines to keep above and below the cursor
set sidescrolloff=8 " Set minimum number of screen columns to keep to the left and right of the cursor
set whichwrap+=<,>,[,],h,l " Allow left-right movement to continue at the end of a line to the next/previous line
set matchpairs+=<:>,「:」 " Bracket highlighting
set iskeyword+=- " Consider hyphens part of a word
set number " Enable line numbers
set relativenumber " Enable relative line numbers
set confirm " Ask for confirmation when handling unsaved or read-only files

"""""""""""
" KEYMAPS "
"""""""""""
" Set space as the leader key
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=" "

" Actions to void
nnoremap c "_c
xnoremap c "_c
nnoremap cc "_S
nnoremap C "_C
xnoremap C "_C

nnoremap s "_s
xnoremap s "_s
nnoremap S "_S
xnoremap S "_S

nnoremap dd "_dd
nnoremap d "_d
xnoremap d "_d

nnoremap x "_x
nnoremap X "_X
xnoremap X "_X


" Paste over selected text without affecting the clipboard
vnoremap p "_dP

" Visual mode mappings --
" Stay in indent mode
vnoremap > >gv
vnoremap < <gv

" Close buffer
nnoremap <C-w> :bdelete<CR>

" Split the window and open netrw
nnoremap <C-b> :Vexplore<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Paste mode toggle
set pastetoggle=<F12>

" Quicker <Esc> in insert mode
inoremap <silent> jk <Esc>

" decrease indent level in insert mode with shift+tab
inoremap <s-tab> <esc><<i

"""""""""""
" UTILITY "
"""""""""""
" Change cursor in different modes
let &t_SI = "\<esc>[6 q"
let &t_EI = "\<esc>[2 q"
if exists('&t_SR')
    let &t_SR = "\<esc>[4 q"
endif
set t_Co=256

" Create undofolder and set it
if !isdirectory("/tmp/vim-undo")
    call mkdir("/tmp/vim-undo", "", 0770)
endif

set undofile " Enable persistent undo
set undodir=/tmp/vim-undo " Set undo folder

" Move the cursor based on physical lines, not the actual lines.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0

" Auto-pair brackets, quotes, and parentheses
" inoremap ( ()<Left>
" inoremap { {}<Left>
" inoremap [ []<Left>
" inoremap ' ''<Left>
" inoremap " ""<Left>

" Toggle line numbers with Ctrl + n
nnoremap <C-n> :set invnumber<CR>:set invrelativenumber<CR>

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

"""""""""""""""
" STATUS LINE "
"""""""""""""""
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \ 't'  : 'TERMINAL'
       \}

                set statusline+=\ %{toupper(g:currentmode[mode()])}
" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %{toupper(g:currentmode[mode()])}\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2


"""""""""""
" FOLDING "
"""""""""""
set foldlevel=0

"""""""""""""""
" COLORSCHEME "
"""""""""""""""
" Fix for tmux and ssh
syntax on
if !has('gui_running') && &term =~ '\%(screen\|tmux\)'  
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"                 
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"                 
endif                                                    

" https://github.com/folke/tokyonight.nvim/tree/main/extras/vim
 let g:colors_name = "tokyonight-moon"
 hi clear
   
 hi ALEErrorSign guibg=NONE guifg=#c53b53
 hi ALEWarningSign guibg=NONE guifg=#ffc777
 hi Bold gui=bold guibg=NONE guifg=#c8d3f5
 hi Character guibg=NONE guifg=#c3e88d
 hi ColorColumn guibg=#1b1d2b
 hi Comment gui=italic guibg=NONE guifg=#636da6
 hi Conceal guibg=NONE guifg=#737aa2
 hi Constant guibg=NONE guifg=#ff966c
 hi Cursor guibg=#c8d3f5 guifg=#222436
 hi CursorColumn guibg=#2f334d
 hi CursorIM guibg=#c8d3f5 guifg=#222436
 hi CursorLine cterm=NONE guibg=#131520
 hi CursorLineNr cterm=bold gui=bold guibg=NONE guifg=#ff9e64
 hi Debug guibg=NONE guifg=#ff966c
 hi DiagnosticError guibg=NONE guifg=#c53b53
 hi DiagnosticHint guibg=NONE guifg=#4fd6be
 hi DiagnosticInfo guibg=NONE guifg=#0db9d7
 hi DiagnosticUnderlineError gui=undercurl guibg=NONE guisp=#c53b53
 hi DiagnosticUnderlineHint gui=undercurl guibg=NONE guisp=#4fd6be
 hi DiagnosticUnderlineInfo gui=undercurl guibg=NONE guisp=#0db9d7
 hi DiagnosticUnderlineWarn gui=undercurl guibg=NONE guisp=#ffc777
 hi DiagnosticUnnecessary guibg=NONE guifg=#444a73
 hi DiagnosticVirtualTextError guibg=#322639 guifg=#c53b53
 hi DiagnosticVirtualTextHint guibg=#273644 guifg=#4fd6be
 hi DiagnosticVirtualTextInfo guibg=#203346 guifg=#0db9d7
 hi DiagnosticVirtualTextWarn guibg=#38343d guifg=#ffc777
 hi DiagnosticWarn guibg=NONE guifg=#ffc777
 hi DiffAdd guibg=#273849
 hi DiffChange guibg=#252a3f
 hi DiffDelete guibg=#3a273a
 hi DiffText guibg=#394b70
 hi Directory guibg=NONE guifg=#82aaff
 hi EndOfBuffer guibg=NONE guifg=#222436
 hi Error guibg=NONE guifg=#c53b53
 hi ErrorMsg guibg=NONE guifg=#c53b53
 hi FloatBorder guibg=#1e2030 guifg=#589ed7
 hi FloatTitle guibg=#1e2030 guifg=#589ed7
 hi FoldColumn guibg=#222436 guifg=#636da6
 hi Folded guibg=#3b4261 guifg=#82aaff
 hi Foo guibg=#ff007c guifg=#c8d3f5
 hi Function guibg=NONE guifg=#82aaff
 hi FzfLuaBorder guibg=#1e2030 guifg=#589ed7
 hi FzfLuaDirPart guibg=NONE guifg=#828bb8
 hi FzfLuaFzfNormal guibg=NONE guifg=#c8d3f5
 hi FzfLuaFzfPointer guibg=NONE guifg=#ff007c
 hi FzfLuaFzfSeparator guibg=#1e2030 guifg=#ff966c
 hi FzfLuaNormal guibg=#1e2030 guifg=#c8d3f5
 hi FzfLuaPreviewTitle guibg=#1e2030 guifg=#589ed7
 hi FzfLuaTitle guibg=#1e2030 guifg=#ff966c
 hi GitGutterAdd guibg=NONE guifg=#b8db87
 hi GitGutterAddLineNr guibg=NONE guifg=#b8db87
 hi GitGutterChange guibg=NONE guifg=#7ca1f2
 hi GitGutterChangeLineNr guibg=NONE guifg=#7ca1f2
 hi GitGutterDelete guibg=NONE guifg=#e26a75
 hi GitGutterDeleteLineNr guibg=NONE guifg=#e26a75
 hi GlyphPalette1 guibg=NONE guifg=#c53b53
 hi GlyphPalette2 guibg=NONE guifg=#c3e88d
 hi GlyphPalette3 guibg=NONE guifg=#ffc777
 hi GlyphPalette4 guibg=NONE guifg=#82aaff
 hi GlyphPalette6 guibg=NONE guifg=#4fd6be
 hi GlyphPalette7 guibg=NONE guifg=#c8d3f5
 hi GlyphPalette9 guibg=NONE guifg=#ff757f
 hi Identifier guibg=NONE guifg=#c099ff
 hi IlluminatedWordRead guibg=#3b4261
 hi IlluminatedWordText guibg=#3b4261
 hi IlluminatedWordWrite guibg=#3b4261
 hi IncSearch guibg=#ff966c guifg=#1b1d2b
 hi Italic gui=italic guibg=NONE guifg=#c8d3f5
 hi Keyword gui=italic guibg=NONE guifg=#86e1fc
 hi LineNr guibg=NONE guifg=#3b4261
 hi LineNrAbove guibg=NONE guifg=#3b4261
 hi LineNrBelow guibg=NONE guifg=#3b4261
 hi LspCodeLens guibg=NONE guifg=#636da6
 hi LspInfoBorder guibg=#1e2030 guifg=#589ed7
 hi LspInlayHint guibg=#24283c guifg=#545c7e
 hi LspReferenceRead guibg=#3b4261
 hi LspReferenceText guibg=#3b4261
 hi LspReferenceWrite guibg=#3b4261
 hi LspSignatureActiveParameter gui=bold guibg=#262f50
 hi MatchParen gui=bold guibg=NONE guifg=#ff966c
 hi MiniAnimateCursor gui=nocombine guibg=NONE
 hi MiniCompletionActiveParameter gui=underline guibg=NONE
 hi MiniCursorword guibg=#3b4261
 hi MiniCursorwordCurrent guibg=#3b4261
 hi MiniDepsTitleError guibg=#e26a75 guifg=#1b1d2b
 hi MiniDepsTitleUpdate guibg=#b8db87 guifg=#1b1d2b
 hi MiniDiffSignAdd guibg=NONE guifg=#b8db87
 hi MiniDiffSignChange guibg=NONE guifg=#7ca1f2
 hi MiniDiffSignDelete guibg=NONE guifg=#e26a75
 hi MiniFilesFile guibg=NONE guifg=#c8d3f5
 hi MiniFilesTitleFocused gui=bold guibg=#1e2030 guifg=#589ed7
 hi MiniHipatternsFixme gui=bold guibg=#c53b53 guifg=#1b1d2b
 hi MiniHipatternsHack gui=bold guibg=#ffc777 guifg=#1b1d2b
 hi MiniHipatternsNote gui=bold guibg=#4fd6be guifg=#1b1d2b
 hi MiniHipatternsTodo gui=bold guibg=#0db9d7 guifg=#1b1d2b
 hi MiniIconsAzure guibg=NONE guifg=#0db9d7
 hi MiniIconsBlue guibg=NONE guifg=#82aaff
 hi MiniIconsCyan guibg=NONE guifg=#4fd6be
 hi MiniIconsGreen guibg=NONE guifg=#c3e88d
 hi MiniIconsGrey guibg=NONE guifg=#c8d3f5
 hi MiniIconsOrange guibg=NONE guifg=#ff966c
 hi MiniIconsPurple guibg=NONE guifg=#fca7ea
 hi MiniIconsRed guibg=NONE guifg=#ff757f
 hi MiniIconsYellow guibg=NONE guifg=#ffc777
 hi MiniIndentscopePrefix gui=nocombine guibg=NONE
 hi MiniIndentscopeSymbol gui=nocombine guibg=NONE guifg=#65bcff
 hi MiniJump guibg=#ff007c guifg=#ffffff
 hi MiniJump2dSpot gui=bold,nocombine guibg=NONE guifg=#ff007c
 hi MiniJump2dSpotAhead gui=nocombine guibg=#1e2030 guifg=#4fd6be
 hi MiniJump2dSpotUnique gui=bold,nocombine guibg=NONE guifg=#ff966c
 hi MiniPickBorderText guibg=#1e2030 guifg=#4fd6be
 hi MiniPickPrompt guibg=#1e2030 guifg=#0db9d7
 hi MiniStarterCurrent gui=nocombine guibg=NONE
 hi MiniStarterFooter gui=italic guibg=NONE guifg=#ffc777
 hi MiniStarterHeader guibg=NONE guifg=#82aaff
 hi MiniStarterInactive gui=italic guibg=NONE guifg=#636da6
 hi MiniStarterItem guibg=#222436 guifg=#c8d3f5
 hi MiniStarterItemBullet guibg=NONE guifg=#589ed7
 hi MiniStarterItemPrefix guibg=NONE guifg=#ffc777
 hi MiniStarterQuery guibg=NONE guifg=#0db9d7
 hi MiniStarterSection guibg=NONE guifg=#65bcff
 hi MiniStatuslineDevinfo guibg=#3b4261 guifg=#828bb8
 hi MiniStatuslineFileinfo guibg=#3b4261 guifg=#828bb8
 hi MiniStatuslineFilename guibg=#2f334d guifg=#828bb8
 hi MiniStatuslineInactive guibg=#1e2030 guifg=#82aaff
 hi MiniStatuslineModeCommand gui=bold guibg=#ffc777 guifg=#1b1d2b
 hi MiniStatuslineModeInsert gui=bold guibg=#c3e88d guifg=#1b1d2b
 hi MiniStatuslineModeNormal gui=bold guibg=#82aaff guifg=#1b1d2b
 hi MiniStatuslineModeOther gui=bold guibg=#4fd6be guifg=#1b1d2b
 hi MiniStatuslineModeReplace gui=bold guibg=#ff757f guifg=#1b1d2b
 hi MiniStatuslineModeVisual gui=bold guibg=#c099ff guifg=#1b1d2b
 hi MiniSurround guibg=#ff966c guifg=#1b1d2b
 hi MiniTablineCurrent guibg=#3b4261 guifg=#c8d3f5
 hi MiniTablineFill guibg=#1b1d2b
 hi MiniTablineHidden guibg=#1e2030 guifg=#737aa2
 hi MiniTablineModifiedCurrent guibg=#3b4261 guifg=#ffc777
 hi MiniTablineModifiedHidden guibg=#1e2030 guifg=#bd9664
 hi MiniTablineModifiedVisible guibg=#1e2030 guifg=#ffc777
 hi MiniTablineTabpagesection guibg=#3b4261 guifg=NONE
 hi MiniTablineVisible guibg=#1e2030 guifg=#c8d3f5
 hi MiniTestEmphasis gui=bold guibg=NONE
 hi MiniTestFail gui=bold guibg=NONE guifg=#ff757f
 hi MiniTestPass gui=bold guibg=NONE guifg=#c3e88d
 hi MiniTrailspace guibg=#ff757f
 hi ModeMsg gui=bold guibg=NONE guifg=#828bb8
 hi MoreMsg guibg=NONE guifg=#82aaff
 hi MsgArea guibg=NONE guifg=#828bb8
 hi NeogitBranch guibg=NONE guifg=#c099ff
 hi NeogitDiffAddHighlight guibg=#273849 guifg=#b8db87
 hi NeogitDiffContextHighlight guibg=#2f334c guifg=#828bb8
 hi NeogitDiffDeleteHighlight guibg=#3a273a guifg=#e26a75
 hi NeogitHunkHeader guibg=#2f334d guifg=#c8d3f5
 hi NeogitHunkHeaderHighlight guibg=#3b4261 guifg=#82aaff
 hi NeogitRemote guibg=NONE guifg=#fca7ea
 hi NeotestAdapterName gui=bold guibg=NONE guifg=#fca7ea
 hi NeotestBorder guibg=NONE guifg=#82aaff
 hi NeotestDir guibg=NONE guifg=#82aaff
 hi NeotestExpandMarker guibg=NONE guifg=#828bb8
 hi NeotestFailed guibg=NONE guifg=#ff757f
 hi NeotestFile guibg=NONE guifg=#4fd6be
 hi NeotestFocused guibg=NONE guifg=#ffc777
 hi NeotestIndent guibg=NONE guifg=#828bb8
 hi NeotestMarked guibg=NONE guifg=#82aaff
 hi NeotestNamespace guibg=NONE guifg=#41a6b5
 hi NeotestPassed guibg=NONE guifg=#c3e88d
 hi NeotestRunning guibg=NONE guifg=#ffc777
 hi NeotestSkipped guibg=NONE guifg=#82aaff
 hi NeotestTarget guibg=NONE guifg=#82aaff
 hi NeotestTest guibg=NONE guifg=#828bb8
 hi NeotestWinSelect guibg=NONE guifg=#82aaff
 hi NonText guibg=NONE guifg=#545c7e
 hi Normal guibg=NONE guifg=#c8d3f5
 hi NormalFloat guibg=#1e2030 guifg=#c8d3f5
 hi NormalNC guibg=#222436 guifg=#c8d3f5
 hi NormalSB guibg=#1e2030 guifg=#828bb8
 hi Operator guibg=NONE guifg=#89ddff
 hi Pmenu guibg=#1e2030 guifg=#c8d3f5
 hi PmenuSbar guibg=#27293a
 hi PmenuSel guibg=#363c58
 hi PmenuThumb guibg=#3b4261
 hi PreProc guibg=NONE guifg=#86e1fc
 hi Question guibg=NONE guifg=#82aaff
 hi QuickFixLine gui=bold guibg=#2d3f76
 hi Search guibg=#3e68d7 guifg=#c8d3f5
 hi SignColumn guibg=#222436 guifg=#3b4261
 hi SignColumnSB guibg=#1e2030 guifg=#3b4261
 hi Sneak guibg=#c099ff guifg=#2f334d
 hi SneakScope guibg=#2d3f76
 hi Special guibg=NONE guifg=#65bcff
 hi SpecialKey guibg=NONE guifg=#545c7e
 hi SpellBad gui=undercurl guibg=NONE guisp=#c53b53
 hi SpellCap gui=undercurl guibg=NONE guisp=#ffc777
 hi SpellLocal gui=undercurl guibg=NONE guisp=#0db9d7
 hi SpellRare gui=undercurl guibg=NONE guisp=#4fd6be
 hi Statement guibg=NONE guifg=#c099ff
 hi StatusLine  guibg=#1e2030 guifg=#828bb8
 hi StatusLineNC guibg=#1e2030 guifg=#3b4261
 hi String guibg=NONE guifg=#c3e88d
 hi Substitute guibg=#ff757f guifg=#1b1d2b
 hi TabLine guibg=#1e2030 guifg=#3b4261
 hi TabLineFill guibg=#1b1d2b
 hi TabLineSel guibg=#82aaff guifg=#1b1d2b
 hi Title gui=bold guibg=NONE guifg=#82aaff
 hi Todo guibg=#ffc777 guifg=#222436
 hi Type guibg=NONE guifg=#65bcff
 hi Underlined gui=underline guibg=NONE
 hi VertSplit guibg=NONE guifg=#1b1d2b
 hi VimwikiHR guibg=NONE guifg=#ffc777
 hi VimwikiHeader1 gui=bold guibg=NONE guifg=#82aaff
 hi VimwikiHeader2 gui=bold guibg=NONE guifg=#ffc777
 hi VimwikiHeader3 gui=bold guibg=NONE guifg=#c3e88d
 hi VimwikiHeader4 gui=bold guibg=NONE guifg=#4fd6be
 hi VimwikiHeader5 gui=bold guibg=NONE guifg=#c099ff
 hi VimwikiHeader6 gui=bold guibg=NONE guifg=#fca7ea
 hi VimwikiHeaderChar guibg=NONE guifg=#ffc777
 hi VimwikiLink guibg=NONE guifg=#82aaff
 hi VimwikiList guibg=NONE guifg=#ff966c
 hi VimwikiMarkers guibg=NONE guifg=#82aaff
 hi VimwikiTag guibg=NONE guifg=#c3e88d
 hi Visual guibg=#2d3f76
 hi VisualNOS guibg=#2d3f76
 hi WarningMsg guibg=NONE guifg=#ffc777
 hi Whitespace guibg=NONE guifg=#3b4261
 hi WildMenu guibg=#2d3f76
 hi WinSeparator gui=bold guibg=NONE guifg=#1b1d2b
 hi debugBreakpoint guibg=#203346 guifg=#0db9d7
 hi debugPC guibg=#1e2030
 hi diffAdded guibg=NONE guifg=#b8db87
 hi diffChanged guibg=NONE guifg=#7ca1f2
 hi diffFile guibg=NONE guifg=#82aaff
 hi diffIndexLine guibg=NONE guifg=#c099ff
 hi diffLine guibg=NONE guifg=#636da6
 hi diffNewFile guibg=NONE guifg=#ff966c
 hi diffOldFile guibg=NONE guifg=#ffc777
 hi diffRemoved guibg=NONE guifg=#e26a75
 hi healthError guibg=NONE guifg=#c53b53
 hi healthSuccess guibg=NONE guifg=#4fd6be
 hi healthWarning guibg=NONE guifg=#ffc777
 hi helpCommand guibg=#444a73 guifg=#82aaff
 hi helpExample guibg=NONE guifg=#636da6
 hi htmlH1 gui=bold guibg=NONE guifg=#c099ff
 hi htmlH2 gui=bold guibg=NONE guifg=#82aaff
 hi illuminatedCurWord guibg=#3b4261
 hi illuminatedWord guibg=#3b4261
 hi lCursor guibg=#c8d3f5 guifg=#222436
 hi qfFileName guibg=NONE guifg=#82aaff
 hi qfLineNr guibg=NONE guifg=#737aa2
 hi! link CurSearch IncSearch
 hi! link Delimiter Special
 hi! link FzfLuaCursor IncSearch
 hi! link FzfLuaFilePart FzfLuaFzfNormal
 hi! link FzfLuaFzfCursorLine Visual
 hi! link FzfLuaHeaderText Title
 hi! link FzfLuaPath Directory
 hi! link LspKindColor Special
 hi! link LspKindEvent Special
 hi! link LspKindFile Normal
 hi! link LspKindFolder Directory
 hi! link LspKindSnippet Conceal
 hi! link MiniAnimateNormalFloat NormalFloat
 hi! link MiniClueBorder FloatBorder
 hi! link MiniClueDescSingle NormalFloat
 hi! link MiniClueTitle FloatTitle
 hi! link MiniDepsChangeAdded diffAdded
 hi! link MiniDepsChangeRemoved diffRemoved
 hi! link MiniDepsHint DiagnosticHint
 hi! link MiniDepsInfo DiagnosticInfo
 hi! link MiniDepsMsgBreaking DiagnosticWarn
 hi! link MiniDepsPlaceholder Comment
 hi! link MiniDepsTitle Title
 hi! link MiniDepsTitleSame Comment
 hi! link MiniDiffOverAdd DiffAdd
 hi! link MiniDiffOverChange DiffText
 hi! link MiniDiffOverContext DiffChange
 hi! link MiniDiffOverDelete DiffDelete
 hi! link MiniFilesBorder FloatBorder
 hi! link MiniFilesCursorLine CursorLine
 hi! link MiniFilesDirectory Directory
 hi! link MiniFilesNormal NormalFloat
 hi! link MiniFilesTitle FloatTitle
 hi! link MiniJump2dDim Comment
 hi! link MiniMapNormal NormalFloat
 hi! link MiniMapSymbolCount Special
 hi! link MiniMapSymbolLine Title
 hi! link MiniNotifyBorder FloatBorder
 hi! link MiniNotifyNormal NormalFloat
 hi! link MiniNotifyTitle FloatTitle
 hi! link MiniOperatorsExchangeFrom IncSearch
 hi! link MiniPickBorder FloatBorder
 hi! link MiniPickIconDirectory Directory
 hi! link MiniPickMatchCurrent CursorLine
 hi! link MiniPickMatchMarked Visual
 hi! link MiniPickNormal NormalFloat
 hi! link MiniPickPreviewLine CursorLine
 hi! link MiniPickPreviewRegion IncSearch
 hi! link WinBar StatusLine
 hi! link WinBarNC StatusLineNC
