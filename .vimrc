set ts=2 sts=2 sw=2 expandtab  "for ruby
" ウインドウの高さ
" set lines=40
" 行番号
set number

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

" NeoBundle
" https://github.com/Shougo/neobundle.vim
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
filetype plugin indent on

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim' "uniteでtabopenするときにvimfilerが必要
NeoBundle 'h1mesuke/vim-alignta' ":Alignで記号とかを揃える

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" Unite
" http://qiita.com/hide/items/77b9c1b0f29577d60397
"インサートモードで開始
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" Unite
" http://qiita.com/knt45/items/6f16c6b041ce309076d6
" http://d.hatena.ne.jp/osyo-manga/20130307/1362621589
" https://gist.github.com/hogesuke/8097443
"インサートモードで開始
let g:unite_enable_start_insert=1
"prefix keyの設定
nmap <Space> [unite]

" nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" nnoremap <silent> [unite]F :<C-u>UniteWithBufferDir -buffer-name=files -default-action=tabopen file<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<Space>-default-action=tabopen<CR>

"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとeキーでバッファと最近開いたファイル一覧を表示
" nnoremap <silent> [unite]e :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
" nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
" nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
"スペースキーとtキーでタブを表示
" nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" https://github.com/JunichiIto/dotfiles/blob/master/.vimrc
" 編集中の行に下線を引く
au InsertLeave * setlocal nocursorline
au InsertEnter * setlocal cursorline
au InsertLeave * highlight StatusLine ctermfg=145 guifg=#c2bfa5 guibg=#000000
au InsertEnter * highlight StatusLine ctermfg=12 guifg=#1E90FF

" http://qiita.com/joker1007/items/9dc7f2a92cfb245ad502


" un~の無視
:set noundofile
