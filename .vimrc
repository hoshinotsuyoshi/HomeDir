"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be improved
endif

" Required:
set runtimepath^=/Users/cesario/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/Users/cesario/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'vim-ruby/vim-ruby'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


"<Unite>
"NeoBundle Scripts-----------------------------
call neobundle#begin(expand('/Users/cesario/.vim/bundle'))
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
call neobundle#end()
"End NeoBundle Scripts-------------------------

let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uF :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 再帰的にファイル一覧
nnoremap <silent> ,uf :<C-u>Unite file_rec <CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"</Unite>

"NeoBundle Scripts-----------------------------
call neobundle#begin(expand('/Users/cesario/.vim/bundle'))
" tags
NeoBundle 'szw/vim-tags'
" powerline
NeoBundle 'powerline/powerline' , {'rtp': 'powerline/bindings/vim/'}
call neobundle#end()
"End NeoBundle Scripts-------------------------

" ag & Unite.vim integration
" http://blog.monochromegane.com/blog/2013/09/18/ag-and-unite/
"<ag>
"NeoBundle Scripts-----------------------------
"vimproc
call neobundle#begin(expand('/Users/cesario/.vim/bundle'))
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
call neobundle#end()
"End NeoBundle Scripts-------------------------

" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
"</ag>

set ts=2 sts=2 sw=2 expandtab
set number
set paste
set noswapfile
set nobackup

" yankしたときにclipboardにもコピーする(なんかうまくいかない)
set clipboard=unnamed

" fileformat=unix にしておけば CrLf は ^M で表示されるらしい
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
