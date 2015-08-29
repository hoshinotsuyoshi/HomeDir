set ts=2 sts=2 sw=2 expandtab  "for ruby
" ウインドウの高さ
" set lines=40
" 行番号
set number
set paste

set noswapfile
set nobackup

set autoindent

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
highlight WhiteSpaceEOL guibg=#fff 
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

" vundle関連
" http://slumbers99.blogspot.jp/2012/02/vim-vundle.html
" vi との互換性OFF
set nocompatible
" ファイル形式の検出を無効にする
filetype off

" Vundle を初期化して
" Vundle 自身も Vundle で管理
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" github にあるプラグイン
" " solarizedを使いたい
" " http://d.hatena.ne.jp/ebc_2in2crc/20121031/1351687541
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256

" vim-scripts プラグイン

" github にないプラグイン

" ファイル形式検出、プラグイン、インデントを ON
filetype plugin indent on 


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
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ



" https://github.com/JunichiIto/dotfiles/blob/master/.vimrc
" 編集中の行に下線を引く
au InsertLeave * setlocal nocursorline
au InsertEnter * setlocal cursorline
au InsertLeave * highlight StatusLine ctermfg=145 guifg=#c2bfa5 guibg=#000000
au InsertEnter * highlight StatusLine ctermfg=12 guifg=#1E90FF

" http://qiita.com/joker1007/items/9dc7f2a92cfb245ad502


" un~の無視
:set noundofile
