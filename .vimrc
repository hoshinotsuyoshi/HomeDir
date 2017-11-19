"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be improved
endif

" Required:
set runtimepath^=/Users/hoshino/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/Users/hoshino/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" golang
NeoBundle 'vim-jp/vim-go-extra'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

set ts=2 sts=2 sw=2 expandtab
set number
set noswapfile
set nobackup
set autoindent

" yankしたときにclipboardにもコピーする
set clipboard=unnamed

" fileformat=unix にしておけば CrLf は ^M で表示される
set fileformat=unix

syntax enable
" set background=dark
set background=light
" let g:solarized_termcolors=256

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


" golang
" http://qiita.com/uchiko/items/4c186292f007535116cc
filetype off
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
endif
if expand("%:t") =~ ".*\.rake"
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endif
if expand("%:t") =~ ".*\.rabl"
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

" ctags
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" 別タブを開いてタグジャンプ
nnoremap <F3> :tab tag <C-R>=expand('<cword>')<CR><CR>

" https://gist.github.com/pinzolo/8168337
" 指定のデータをレジスタに登録する
function! s:Clip(data)
  let @*=a:data
  echo "clipped: " . a:data
endfunction

" 現在開いているファイルのパスをレジスタへ
command! -nargs=0 ClipPath call s:Clip(expand('%:p'))
