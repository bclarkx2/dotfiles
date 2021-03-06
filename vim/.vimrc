" VIM config file

""" Plugins
call plug#begin('~/.vim/plugged')

"" Snippets
Plug 'ervandew/supertab'
Plug 'ycm-core/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'EinfachToll/DidYouMean'

"" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'FooSoft/vim-argwrap'

"" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-obsession'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

"" Colorschemes
Plug 'gilgigilgil/anderson.vim'
Plug 'lifepillar/vim-solarized8'

"" Languages: Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Languages: Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

"" Lanugages: Mustache
Plug 'mustache/vim-mustache-handlebars'

"" Languages: SQL
Plug 'cosminadrianpopescu/vim-sql-workbench'

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
"colorscheme anderson 	" use a vim colorscheme


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
let g:go_fmt_command = "goimports"
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

autocmd FileType go let b:argwrap_tail_comma = 1 " Add trailing comma

autocmd FileType go setlocal foldmethod=syntax 	" Fold on go syntax

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

"" Go: Mappings
augroup go
	autocmd!

	" Execute gofmt in addition to goimports on write
	au BufWritePost *.go silent execute "!gofmt -s -w <afile>" | redraw!
	
	" Show by default 4 spaces for a tab
	au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
	
	" Run/build
	au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	au FileType go nmap <leader>r <Plug>(go-run)
	au FileType go nmap <leader>t <Plug>(go-test)
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
	
	" Testing info
	au FileType go nmap <leader>ct <Plug>(go-coverage-toggle)
	au FileType go nmap <leader>cb <Plug>(go-coverage-browser)

augroup END


""" Python
"" Python: settings
let g:pymode_lint_on_fly = 1
let g:pymode_lint_checkers = ['pylint']


"" Python: mappings
let g:pymode_doc_bind = '<leader>gd'


"" Markdown: settings
autocmd FileType markdown :set tw=80 	" Don't go past 80 columns
autocmd BufWritePost *.md silent execute "!doctoc <afile> &>/dev/null" | redraw!


"" Mustache: settings
autocmd FileType html.mustache setlocal ts=4 sts=4 	" Use 2 space tabstop
autocmd FileType html.mustache setlocal sw=4 		" Indent new lines 2 spaces
autocmd FileType html.mustache setlocal expandtab 	" Don't allow tabs


""" Bash
autocmd FileType sh setlocal ts=2 sts=2 		" Use 2 space tabstop
autocmd FileType sh setlocal sw=2 			" Indent new lines 2 spaces
autocmd FileType sh setlocal expandtab 			" Don't allow tabs


""" YAML
autocmd FileType yaml setlocal foldmethod=indent 	" Fold on indents
autocmd FileType yaml setlocal ts=2 sts=2 		" Use 2 space tabstop
autocmd FileType yaml setlocal sw=2 			" Indent new lines 2 spaces
autocmd FileType yaml setlocal expandtab 		" Don't allow tabs


""" JSON
autocmd FileType json setlocal foldmethod=syntax 	" Fold on json syntax


""" SQL
let g:sw_exe = "/home/bclark/tools/sql-workbench/sqlwbconsole.sh"

""" jq
"" Use jq inside vim on text in current buffer
command! -nargs=1 Jq :% !jq <q-args>


""" NERDtree
"" Start NERDtree automatically on directories
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Bind command to toggle tree
map <C-t> :NERDTreeToggle<CR>


""" GitGutter
set updatetime=10 	           " Refresh faster
set signcolumn=yes 	           " Always show sign column to avoid screen jump
highlight! link SignColumn LineNr  " Use bg color in sign column


""" SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'  " This allows using both YCM and UltiSnips


""" YCM
set completeopt=menuone
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']  " Navigate down menu
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']  " Navigate up menu
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>'] 	    " Select option
let g:ycm_enable_diagnostic_highlighting = 0 		    " Remove highlighting
let g:ycm_filetype_blacklist = {
	\ 'vimscript': 1,
	\}
"highlight YcmErrorLine guibg=#3f3f00
"highlight YcmErrorSection guibg=#3f3f00
"highlight YcmWarningLine guibg=#3f003f
"highlight YcmWarningSection guibg=#3f003f


""" UltiSnips
let g:UltiSnipsExpandTrigger = "<Insert>" 	" Expand a snippet
let g:UltiSnipsJumpForwardTrigger = "<Tab>" 	" Move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>" 	" Move backward through tabstops
let g:UltiSnipsEditSplit = "context" 		" Open snip edit vert or horizontal
command! Snip :UltiSnipsEdit 			" Rename snip edit command
