set ts=20 sw=2 sts=2

" カラー設定:
" colorscheme desert 
" http://qiita.com/Humangas/items/848f0318dfc3c6f5b8e2
syntax enable
" set background=dark
set background=light
colorscheme solarized
let g:solarized_termcolors=256

" ウインドウの高さ
set lines=40
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
