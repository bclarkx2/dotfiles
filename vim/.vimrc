" VIM config file


""" Plugins
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'

call plug#end()


""" Variables
let mapleader=","


""" Text editing
"Autoindent new lines
set autoindent

"Save file on calling :make
set autowrite


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
au FileType go nmap <leader>l <Plug>(go-metalinter)
au FileType go nmap <leader>i <Plug>(go-install)
au FileType go nmap <leader>d <Plug>(go-doc-browser)
au FileType go nmap <leader>ct <Plug>(go-coverage-toggle)
au FileType go nmap <leader>cb <Plug>(go-coverage-browser)
au FileType go nmap <leader>a <Plug>(go-alternate-edit)
