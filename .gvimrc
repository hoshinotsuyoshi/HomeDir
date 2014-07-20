" http://qiita.com/Humangas/items/848f0318dfc3c6f5b8e2

" fileformat=unix にしておけば CrLf は ^M で表示されるらしい
:set fileformat=unix

syntax enable
" set background=dark
set background=light
colorscheme solarized
let g:solarized_termcolors=256

" ウインドウの高さ
set lines=60
" ウインドウの幅
set columns=180
" 行番号
set number
 
set noswapfile
set nobackup

" https://github.com/cyborgninja/vimrc/blob/master/.vimrc
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

" https://github.com/cyborgninja/vimrc/blob/master/.vimrc
"----------------------------------------------------
" インデント
"----------------------------------------------------
" オートインデントを無効にする
"set noautoindent
" タブが対応する空白の数
" set tabstop=20
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
"set softtabstop=2
" インデントの各段階に使われる空白の数
"set shiftwidth=2
" タブを挿入するとき、代わりに空白を使わない
"set noexpandtab

"http://qiita.com/m-yamashita/items/28ce6f90b1d3fdc2eb24
"----------------------------------------------------
" 検索
"----------------------------------------------------
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

set transparency=10
