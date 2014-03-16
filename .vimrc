set ts=20 sw=2 sts=2

" ウインドウの高さ
set lines=40
" 行番号
set number
 
set noswapfile
set nobackup

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

" vim-scripts プラグイン

" github にないプラグイン

" ファイル形式検出、プラグイン、インデントを ON
filetype plugin indent on 


" カラー設定:
colorscheme desert 

"-FuzzyFinder-------------
" http://d.hatena.ne.jp/mickey24/20090310/1236633777
set showtabline=2

" Tabs
"nnoremap <Space>t t
"nnoremap <Space>T T
"nnoremap t <Nop>
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tk :<C-u>tabclose<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>

" FuzzyFinder.vim
"nnoremap <Space>f f
"nnoremap <Space>F F
"nnoremap f <Nop>
"nnoremap <silent> fb :<C-u>FuzzyFinderBuffer!<CR>
"nnoremap <silent> ff :<C-u>FuzzyFinderFile! <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
"nnoremap <silent> fm :<C-u>FuzzyFinderMruFile!<CR>
nnoremap <silent> tb :<C-u>tabnew<CR>:tabmove<CR>:FuzzyFinderBuffer!<CR>
nnoremap <silent> tf :<C-u>tabnew<CR>:tabmove<CR>:FuzzyFinderFile! <C-r>=expand('#:~:.')[:-1-len(expand('#:~:.:t'))]<CR><CR>
nnoremap <silent> tm :<C-u>tabnew<CR>:tabmove<CR>:FuzzyFinderMruFile!<CR>
