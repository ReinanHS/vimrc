" Definindo algumas configurações ao VIM para programação
" Este arquivo de origem vem do repositório do git-for-windows build-extra (git-extra/vimrc)
" Esse arquivo foi modificado por ReinanHS e está disponível no github em
" (reinanhs/vimrc)

ru! defaults.vim                " Use os padrões do Vim aprimorados
set mouse=                      " Redefinir a configuração do mouse por padrões
aug vimStartup | au! | aug END  " Reverter o último salto posicionado, conforme definido abaixo
let g:skip_defaults_vim = 1     " Não aceita o defaults.vim novamente ( depois de carregar este sistema vimrc )

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set wildmode=list:longest,longest:full   " Better command line completion

" Show EOL type and last modified timestamp, right after the filename
" Set the statusline
set statusline=%f               " filename relative to current $PWD
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " readonly flag
set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...
set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp
set statusline+=%=              " Rest: right align
set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
set statusline+=\ %P            " Position in buffer: Percentage

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible
  if &t_Co == 8
    set t_Co = 256              " Use at least 256 colors
  endif
  " set termguicolors           " Uncomment to allow truecolors on mintty
endif
"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

    " Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && &filetype !~# 'commit\|gitrebase'
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff

      autocmd Filetype diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/
endif " has("autocmd")


" Minhas Configurações
set number
set relativenumber

let mapleader="\<space>"
nnoremap <loader>; A;<esc>
"nnoremap <loader>ev :vsplit ~/etc/vimrm
"nnoremap <loader>sv :source ~/etc/vimrm

"filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Tema do VSCode
Plugin 'tomasiser/vim-code-dark'
" Syntax
Plugin 'sheerun/vim-polyglot'
" Plugin dos (){}
Plugin 'cohama/lexima.vim'
" Auto Completar
Plugin 'honza/vim-snippets'
" Menu
Plugin 'vim-airline/vim-airline'
" Esse plugin não funciona muito bem no windows
" :Files
" :AG
"Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plugin 'junegunn/fzf.vim'

call vundle#end()

set t_Co=256
set t_ut=
colorscheme codedark

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
