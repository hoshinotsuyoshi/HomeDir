"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/hoshino/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/hoshino/.cache/dein')
  call dein#begin('/Users/hoshino/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/hoshino/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })
  let s:toml = '~/.config/nvim/dein.toml'
  call dein#load_toml(s:toml, {'lazy': 0})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" denite
" https://blog.hatappi.me/entry/2017/08/28/191529
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap <silent> <Space>f :<C-u>Denite file_rec<CR>
"nnoremap <silent> <Space>g :<C-u>Denite grep<CR>
nnoremap <silent> <Space>l :<C-u>Denite line<CR>
nnoremap <silent> <Space>u :<C-u>Denite file_mru<CR>

nnoremap <silent> <Space>r :<C-u>Denite command_history<CR>
nnoremap <silent> <Space>b :<C-u>Denite buffer<CR>

" denite grep
" https://qiita.com/pocari/items/1b76c211d5555fa87834
nnoremap [denitegrep] <Nop>
nmap <silent> <Space>g [denitegrep]

" -buffer-name=
nnoremap <silent> [denitegrep]g  :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>

" Denite grep検索結果を再表示する
nnoremap <silent> [denitegrep]r :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
" resumeした検索結果の次の行の結果へ飛ぶ
nnoremap <silent> [denitegrep]n :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=+1 -immediately<CR>
" resumeした検索結果の前の行の結果へ飛ぶ
nnoremap <silent> [denitegrep]p :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=-1 -immediately<CR>

"End denite -------------------


" true color
" set termguicolors
colorscheme iceberg

"""""""""以上がneovim独自設定
set ts=2 sts=2 sw=2 expandtab
set number
set noswapfile
set nobackup
set autoindent

set clipboard=unnamed

" fileformat=unix にしておけば CrLf は ^M で表示される
set fileformat=unix

syntax enable
" set background=dark
set background=light

" https://github.com/cyborgninja/vimrc/blob/master/.vimrc
"
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" 末尾の半角スペースを視覚化
highlight WhiteSpaceEOL guibg=#ffffff 
2match WhiteSpaceEOL /\S\@<=\s\+$/

"Tab、行末の半角スペースを明示的に表示する。
"https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-zenkaku
set list
set listchars=tab:^\ ,trail:~

" netrw関連
" see http://blog.tojiru.net/article/234400966.html
"
" netrwは常にtree view
let g:netrw_liststyle = 3
" netrwは'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" netrwは'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

set encoding=utf-8

" http://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    , [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" ,1 で1番左のタブ、,2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" ,c 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" ,x タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" ,n 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" ,p 前のタブ



" https://github.com/JunichiIto/dotfiles/blob/master/.vimrc
" 編集中の行に下線を引く
au InsertLeave * setlocal nocursorline
au InsertEnter * setlocal cursorline
au InsertLeave * highlight StatusLine ctermfg=145 guifg=#c2bfa5 guibg=#000000
au InsertEnter * highlight StatusLine ctermfg=12 guifg=#1E90FF

" http://qiita.com/joker1007/items/9dc7f2a92cfb245ad502


" un~の無視
:set noundofile


" <ペースト問題>
" https://github.com/ConradIrwin/vim-bracketed-paste/blob/d3c8f789c5d956dc658c21dce2e23e8191a1021e/plugin/bracketed-paste.vim

if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te = "\e[?2004l" . &t_te

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
" </ペースト問題>



" golang
" http://qiita.com/uchiko/items/4c186292f007535116cc
filetype off
filetype plugin indent off
" set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on
autocmd FileType go autocmd BufWritePre <buffer> Fmt
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

" golang
" http://blog.restartr.com/2014/04/20/vimrc-noexpandtab-in-golang/
if expand("%:t") =~ ".*\.go"
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
endif

" ruby
" http://easyramble.com/set-vim-indent-with-filetype.html
if expand("%:t") =~ ".*\.rb"
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set spell
  set spelllang=en,cjk
endif
if expand("%:t") =~ ".*\.rake"
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endif
if expand("%:t") =~ ".*Rakefile"
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endif
if expand("%:t") =~ ".*Gemfile"
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endif

" スペルチェック
" http://qiita.com/crispy/items/9a49d7dc792740f062ab
set spell
set spelllang=en,cjk

" 別タブを開いてタグジャンプ
nnoremap <F3> :tab tag <C-R>=expand('<cword>')<CR><CR>

" GitHubで開く https://github.com/tonchis/vim-to-github
nnoremap <silent> <Space><Space>g :<C-u>ToGithub<CR>

" jjでEscape
inoremap <silent> jj <ESC>

" ctags
" https://qiita.com/hisawa/items/fc5300a526cb926aef08
set rtp+=/usr/local/opt/fzf
" deniteと合わせて上部に表示
let g:fzf_layout = { 'up': '~40%' }

" <C-]>でタグ検索
nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>

" fzfからファイルにジャンプできるようにする
let g:fzf_buffers_jump = 1
