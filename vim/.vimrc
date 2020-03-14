" VIM config file


""" Plugins
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()


""" Variables
let mapleader=","


""" Text editing
"" Autoindent new lines
set autoindent

"" Save file on calling :make
set autowrite

"" Reload automatically on disk change
set autoread

"" Autocomplete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


""" Navigation
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
set hlsearch

"" Scroll: arrow keys
map <C-S-Up> <C-Y>
map <C-S-Down> <C-E>



""" Config
"" .vimrc: edit
command! Ev :e $MYVIMRC

"" .vimrc: autoload changes
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END


""" Display
set display+=lastline
set showmatch
set cursorline
set scrolloff=12
set number


""" Shortcuts


""" Go
"" Go: Config
let g:go_fmt_command = "goimports"
let g:go_addtags_transform="camelcase"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" let g:go_metalinter_autosave = 1
let g:go_highlight_functions = 1
" let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_contraints = 1
let g:go_highlight_extra_types = 1

"" Go: Simple Mappings
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>ml <Plug>(go-metalinter)
au FileType go nmap <leader>gd <Plug>(go-doc-browser)
au FileType go nmap <leader>ct <Plug>(go-coverage-toggle)
au FileType go nmap <leader>cb <Plug>(go-coverage-browser)
au FileType go nmap <leader>a <Plug>(go-alternate-edit)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>d <Plug>(go-def)
au FileType go nmap <leader>l <Plug>(go-decls)
au FileType go nmap <leader>f <Plug>(go-fmt)

command! Gd :GoDef
command! Gl :GoDecls
command! Gi :GoInfo

""" jq
command! -nargs=1 Jq :% !jq <q-args>


""" NERDtree
"" Start NERDtree automatically on directories
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"" Bind command to toggle tree
map <C-t> :NERDTreeToggle<CR>
