" VIM config file

""" Plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'EinfachToll/DidYouMean'

"" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'FooSoft/vim-argwrap'
Plug 'godlygeek/tabular'
Plug 'AndrewRadev/sideways.vim'

"" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-obsession'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'

"" Colorschemes

"" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" Languages: Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Languages: Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

"" Lanugages: Mustache
Plug 'mustache/vim-mustache-handlebars'

"" Languages: Typescript
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

"" Languages: LaTeX
Plug 'lervag/vimtex'

"" Languages: graphviz 
Plug 'liuchengxu/graphviz.vim'

"" Languages: markdown
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['markdown'] }

"" AI
Plug 'github/copilot.vim'

call plug#end()


""" Variables
let mapleader=","


""" General
set term=xterm-256color  " Use a terminal type that tmux understands


""" Text editing
"" Autoindent new lines
set autoindent
set smartindent

"" Read/write
set autowrite 	" Save file on calling :make
set autoread 	" Reload automatically on disk change


"" Copy/paste
set clipboard=unnamed,unnamedplus 	" Past to both 'primary' and 'clipboard' linux clipboard buffers
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')


"" Folding
set foldlevel=99  " Keep unfolded by default when opening file

"" ArgWrap
nnoremap <silent> <leader>w :ArgWrap<CR>



""" Commands
"" Force write: use sudo to silently write to a readonly buffer (DANGER)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"" Repeat last command on visual selection
""  This grabs the previous command and re-applies it to whatever
""  is currently in your visual selection.
xnoremap <leader>. q:<UP>I'<,'><Esc>$

"" Find git merge conflicts
command! Df :normal /<<<<<<<\|=======\|>>>>>>>/^

"" Delete all git merge conflicts
command! Dd :g/<<<<<<<\|=======\|>>>>>>>/d

set incsearch  " Show search results as you type the query


""" Navigation
"" Modes
imap jk <Esc>
imap kj <Esc>

"" Menu
set wildmenu
set wildmode=longest:full,full

"" Split: open things below and right
set splitbelow
set splitright

"" Search: center on cursor
noremap n nzz
noremap N Nzz
noremap gg ggzz
noremap G Gzz

"" Search: highlight
set hlsearch	" show highlight on search

"" Search: case
set ignorecase	" ignore case
set smartcase 	" ... unless search term starts with upper case

"" Scroll: arrow keys
map <C-S-Up> <C-Y>
map <C-S-Down> <C-E>

"" Mouse
set mouse=a

"" Re-opening: open file to previous location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

"" When quitting buffer, try to close quickfix/location list
autocmd QuitPre * execute "lclose|cclose"


""" Config
"" .vimrc: edit and load
command! Ev :e $MYVIMRC
command! Lv :source $MYVIMRC

"" .vimrc: autoload changes
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END


""" Display
set display+=lastline
set cursorline 		" underline current line
set scrolloff=12	" start scrolling when there are this many lines remaining on screen
set number		" show line numbers
set relativenumber 	" make line numbers relative
set showcmd 		" show normal mode command as you type it
set lazyredraw 		" don't redraw screen during macro

"" Color scheme
syntax on 		" enable syntax highlighting
" set background=dark


""" Shortcuts
"" hide highlights
nnoremap <silent> <return> :let @/=""<return><return>

"" save
nnoremap ww :update<cr>

"" toggle relative line numbers
nnoremap <C-L> :set invrelativenumber<CR>


""" Statusline
set laststatus=2
set statusline=%n  						" Buffer number
set statusline+=\ 						" _
set statusline+=%f         		 			" Path to the file
set statusline+=%m 						" Modified flag
set statusline+=%< 						" Truncate point
set statusline+=\ 
set statusline+=%{FugitiveStatusline()}                         " Git branch
set statusline+=%= 			 			" Right/left separator
set statusline+=%y 						" File type
set statusline+=\  						" _
set statusline+=%{&fileencoding?&fileencoding:&encoding} 	" File encoding
set statusline+=\[%{&fileformat}\] 				" File format
set statusline+=%6l/%-5L 					" Current line / total lines
set statusline+=\ 						" _
set statusline+=%4c/%-4{col('$')-1} 				" Column number

""" Go
"" Go: Config
let g:go_fmt_command = "gopls"
let g:go_gopls_gofumpt = 1
let g:go_addtags_transform="camelcase"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode='gopls'
let g:go_rename_command = 'gopls'
" let g:go_metalinter_autosave = 1
let g:go_highlight_functions = 1
" let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_contraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_doc_window_popup_window = 1
let g:go_auto_sameids = 1 			 " Auto-highlight identifier
let g:go_updatetime = 100 			 " Refresh for sameids
let g:go_list_type = "quickfix" 		 " Always use quickfix
let g:go_debug = [] 				 " Log debug output

"" Go: Functions
" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
		elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

function! TogglePointer(char)
	if a:char == " "
		return " &"
	elseif a:char == "&"
		return "*"
	elseif a:char == "*"
		return ""
	else 
		return a:char . "&"
	endif
endfunction

"" Go: Mappings
augroup go
	autocmd!

	" Add trailing comma
	au FileType go let b:argwrap_tail_comma = 1 

	" Fold on go syntax	
	au FileType go setlocal foldmethod=syntax 

	" Execute gofmt in addition to goimports on write
	au BufWritePost *.go silent execute "!gofmt -s -w <afile>" | redraw!
	
	" Show by default 4 spaces for a tab
	au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
	
	" Run/build
	au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	au FileType go nmap <leader>g <Plug>(go-generate)

	" Navigate
	au FileType go nmap <leader>a <Plug>(go-alternate-edit)

	" Edit
	au FileType go nmap <leader>r <Plug>(go-rename)
	au FileType go nmap <leader>f :GoFillStruct<CR>
	au FileType go nmap <leader>c ]}V%y%p

	" Show info
	au FileType go nmap <leader>i <Plug>(go-info)
	au FileType go nmap <leader>l <Plug>(go-decls)
	au FileType go nmap <leader>gd <Plug>(go-doc)
	au FileType go nmap <leader>d <Plug>(go-def)
	au FileType go nmap <leader>dv <Plug>(go-def-vertical)
	au FileType go nmap <leader>ds <Plug>(go-def-split)
	au FileType go nmap <leader>dt <Plug>(go-def-type)
	au FileType go nmap <leader>ref <Plug>(go-referrers)
	
	" Format
	au FileType go nmap <leader>ml <Plug>(go-metalinter)
	au FileType go nmap <leader>q gqac
	
	" Testing info
	au FileType go nmap <leader>ct <Plug>(go-coverage-toggle)
	au FileType go nmap <leader>cb <Plug>(go-coverage-browser)

	" Add godoc style comment
	au FileType go nmap <leader>id yiwO// <ESC>pa 

	" Toggle pointer
	au FileType go nmap <leader>tp ebhdl"=TogglePointer(@@)<CR>P

	" Copy line location in remote
	au FileType go nmap <leader>o :0:GBrowse!<return><return>
	au FileType go vmap <leader>o :GBrowse!<return><return>
augroup END


""" Python
"" Python: settings
let g:pymode_lint_on_fly = 1
let g:pymode_lint_checkers = ['pylint']
let g:pymode_lint_signs = 0


"" Python: mappings
let g:pymode_doc_bind = '<leader>gd'


""" Markdown
augroup markdown
	autocmd!
	autocmd FileType markdown setlocal tw=80 	        " Don't go past 80 columns
	autocmd FileType markdown setlocal ts=2 sts=2 sw=2 	" Use 2 space tabstop
	autocmd FileType markdown setlocal expandtab            " Don't allow tabs
	autocmd BufWritePost *.md PrettierAsync
augroup END


""" Mustache
augroup mustache
	autocmd!
	autocmd FileType html.mustache setlocal ts=4 sts=4 	" Use 4 space tabstop
	autocmd FileType html.mustache setlocal sw=4 		" Indent new lines 4 spaces
	autocmd FileType html.mustache setlocal expandtab 	" Don't allow tabs
augroup END


""" Conf
augroup conffile
	autocmd!
	au BufRead,BufNewFile *.conf setfiletype conf
	autocmd FileType conf setlocal ts=4 sts=4               " Use 4 space tabstop
	autocmd FileType conf setlocal sw=4                     " Indent new lines 4 spaces
	autocmd FileType conf setlocal expandtab                " Don't allow tabs
augroup END


""" Bash
augroup bash
	autocmd!
	autocmd FileType sh setlocal ts=2 sts=2 		" Use 2 space tabstop
	autocmd FileType sh setlocal sw=2 			" Indent new lines 2 spaces
	autocmd FileType sh setlocal expandtab 			" Don't allow tabs
augroup END

""" Typescript
augroup typescript 
	autocmd!

	" Set folding 
	autocmd FileType typescript setlocal foldmethod=syntax  " Fold on Typescript syntax
	autocmd FileType typescript setlocal foldcolumn=1 	" Indicate folding on left
	autocmd FileType typescript setlocal foldlevelstart=99  " Start with all folds opened

	" Set spacing and indentation
	autocmd FileType typescript setlocal ts=2 sts=2 	" Use 2 space tabstop
	autocmd FileType typescript setlocal sw=2 		" Indent new lines 2 spaces
	autocmd FileType typescript setlocal expandtab 		" Don't allow tabs

	" Use prettier for formatting
	" autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

	" Coc: navigation
	autocmd FileType typescript nmap <leader>d <Plug>(coc-definition)
	autocmd FileType typescript nmap <leader>dt <Plug>(coc-type-definition)
	autocmd FileType typescript nmap <leader>ref <Plug>(coc-references)
	autocmd FileType typescript nmap <leader>i <Plug>(coc-implementation)
	autocmd FileType typescript nmap [g <Plug>(coc-diagnostic-prev)
	autocmd FileType typescript nmap ]g <Plug>(coc-diagnostic-next)

	" Coc: edit
	autocmd FileType typescript nmap <leader>do <Plug>(coc-codeaction)
	autocmd FileType typescript nmap <leader>r <Plug>(coc-rename)

	autocmd FileType typescript xmap <leader>a <Plug>(coc-codeaction-selected)
	autocmd FileType typescript nmap <leader>a <Plug>(coc-codeaction-selected)
	
	autocmd FileType typescript nmap <leader>qf <Plug>(coc-fix-current)

	" Coc: text objects
	autocmd FileType typescript xmap if <Plug>(coc-funcobj-i)
	autocmd FileType typescript omap if <Plug>(coc-funcobj-i)
	autocmd FileType typescript xmap af <Plug>(coc-funcobj-a)
	autocmd FileType typescript omap af <Plug>(coc-funcobj-a)
	autocmd FileType typescript xmap ic <Plug>(coc-classobj-i)
	autocmd FileType typescript omap ic <Plug>(coc-classobj-i)
	autocmd FileType typescript xmap ac <Plug>(coc-classobj-a)
	autocmd FileType typescript omap ac <Plug>(coc-classobj-a)

	" Coc: formatting
	autocmd FileType typescript xmap <leader>f <Plug>(coc-format-selected)
	autocmd FileType typescript nmap <leader>f <Plug>(coc-format-selected)

	" Coc: lists
	autocmd FileType typescript nnoremap <silent><nowait> <leader>b :<C-u>CocList diagnostics<cr>
augroup END

""" YAML
augroup yaml
	autocmd!
	autocmd FileType yaml setlocal foldmethod=syntax 	" Fold on indents
	autocmd FileType yaml setlocal ts=2 sts=2 		" Use 2 space tabstop
	autocmd FileType yaml setlocal sw=2 			" Indent new lines 2 spaces
	autocmd FileType yaml setlocal expandtab 		" Don't allow tabs
augroup END


""" JSON
augroup json
	autocmd!
	autocmd FileType json setlocal foldmethod=syntax 	" Fold on json syntax
augroup END

""" LaTeX
augroup latex
	autocmd FileType tex setlocal ts=2 sts=2 		" Use 2 space tabstop
	autocmd FileType tex setlocal sw=2 			" Indent new lines 2 spaces
	autocmd FileType tex setlocal expandtab 		" Don't allow tabs
	filetype plugin indent on 
	syntax enable
	let g:vimtex_imaps_enabled = 0 " disable insert mode mappings in favor of UltiSnips
augroup END


""" graphviz
augroup graphviz
	autocmd FileType dot setlocal ts=2 sts=2 		" Use 2 space tabstop
	autocmd FileType dot setlocal sw=2 			" Indent new lines 2 spaces
	autocmd FileType dot setlocal expandtab 		" Don't allow tabs
augroup END

""" sideways
augroup sideways
	nnoremap <c-h> :SidewaysLeft<CR>
	nnoremap <c-l> :SidewaysRight<CR>
	omap aa <Plug>SidewaysArgumentTextobjA
	xmap aa <Plug>SidewaysArgumentTextobjA
	omap ia <Plug>SidewaysArgumentTextobjI
	xmap ia <Plug>SidewaysArgumentTextobjI
	nmap <leader>si <Plug>SidewaysArgumentInsertBefore
	nmap <leader>sa <Plug>SidewaysArgumentAppendAfter
	nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
	nmap <leader>sA <Plug>SidewaysArgumentAppendLast
augroup END

""" jq
"" Use jq inside vim on text in current buffer
command! -nargs=1 Jq :% !jq <q-args>


""" GitGutter
set updatetime=10 	           " Refresh faster
set signcolumn=yes 	           " Always show sign column to avoid screen jump
highlight! link SignColumn LineNr  " Use bg color in sign column

""" git-fugitive
command! Review let base_branch = system('gh pr status --json baseRefName --jq .currentBranch.baseRefName') | exec 'Gvdiffsplit' base_branch

""" Coc
"" Configure language servers
let g:coc_global_extensions = [
	\ 'coc-tsserver'
	\ ]
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Make <CR> confirm the current selection in the popup menu
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Make <shift>+<tab> go backwards in the popup menu
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()


""" Copilot
augroup copilot
	" Remove default copilot mappings -- they don't work well in my
	" terminal.
	autocmd VimEnter * iunmap <M-C-Right>
	autocmd VimEnter * iunmap <M-Right>
	autocmd VimEnter * iunmap <M-Bslash>
	autocmd VimEnter * iunmap <M-[>
	autocmd VimEnter * iunmap <M-]>
	autocmd VimEnter * iunmap <C-]>

	" Add mappings for working with current suggestion.
	imap <Esc>0 <Plug>(copilot-next)
	imap <Esc>9 <Plug>(copilot-previous)
	imap <Esc>- <Plug>(copilot-dismiss)
	imap <Esc>\ <Plug>(copilot-suggest)
	imap <Esc>8 <Plug>(copilot-accept-word)
	imap <Esc>* <Plug>(copilot-accept-line)
augroup END


""" UltiSnips
let g:UltiSnipsExpandTrigger = "<Insert>" 	" Expand a snippet
let g:UltiSnipsJumpForwardTrigger = "<Tab>" 	" Move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>" 	" Move backward through tabstops
let g:UltiSnipsEditSplit = "context" 		" Open snip edit vert or horizontal
command! Snip :UltiSnipsEdit 			" Rename snip edit command
