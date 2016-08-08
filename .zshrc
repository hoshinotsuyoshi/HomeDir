alias ll='ls -alF'

### go
if [ -x "`which go`" ]; then
      export GOROOT=`go env GOROOT`
      export GOPATH=$HOME/go
      export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#左のほうにユーザ名とカレントディレクトリを表示するPROMPT
PROMPT='[%F{blue}%d%f]$ '

# http://futurismo.biz/archives/1363
## Screenでのコマンド共有用
## シェルを横断して.zshhistoryに記録
setopt inc_append_history
## ヒストリを共有
setopt share_history

# 自動補完を有効にする
# コマンドの引数やパス名を途中まで入力して <Tab> を押すといい感じに補完してくれる
# 例： `cd path/to/<Tab>`, `ls -<Tab>`
autoload -U compinit; compinit

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd
# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# 拡張 glob を有効にする
# glob とはパス名にマッチするワイルドカードパターンのこと
a （たとえば `mv hoge.* ~/dir` における "*"）
# 拡張 glob を有効にすると # ~ ^ もパターンとして扱われる
# どういう意味を持つかは `man zshexpn` の FILENAME GENERATION を参照
# setopt extended_glob

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups


# http://qiita.com/PSP_T/items/c1a1567b2b76051f50c4 
# コマンドがスペースで始まる場合、コマンド履歴に追加しない
# 例： <Space>echo hello と入力
setopt hist_ignore_space

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=300000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=3000000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# 全履歴を一覧表示する
function history-all { history -E 1 }
# ここで､特定のキーワードのみを覚えていた場合､それらをつなぎあわせて検索することで､複雑なワンライナーの再利用も簡単になります｡
# history-all | grep find | grep tr

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 余分な空白は詰めて記録
setopt hist_reduce_blanks  

# 古いコマンドと同じものは無視 
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開         
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# http://qiita.com/ayakix/items/44b990335169ca9e3d39
# プロンプトのカラー表示を有効
autoload -U colors
# colors
# Color
setopt prompt_subst
# ls時のカラー表記
export LSCOLORS=gxfxcxdxbxegedabagacad
# ファイルリスト補完時、ディレクトリをシアン
zstyle ':completion:*' list-colors 'di=36;49'

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
# chruby
# use .ruby-version
# http://www.codeography.com/2013/09/23/how_i_setup_chruby.html
if [[ -e /usr/local/share/chruby ]]; then
  # Load chruby
  source '/usr/local/share/chruby/chruby.sh'

  # Automatically switch rubies
  source '/usr/local/share/chruby/auto.sh'

  # Set a default ruby if a .ruby-version file exists in the home dir
  if [[ -f ~/.ruby-version ]]; then
    chruby $(cat ~/.ruby-version)
  fi
fi

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# http://qiita.com/ikm/items/0e498981c6b19ac8d19b
# 
. /usr/local/etc/profile.d/z.sh
function _Z_precmd {
  z --add "$(pwd -P)" 61 }
  precmd_functions=($precmd_functions _Z_precmd)

# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

whence direnv >/dev/null && eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/hoshino/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/hoshino/google-cloud-sdk/completion.zsh.inc'

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${GOPATH}/src/github.com/rbenv/rbenv/bin:${PATH} && \
    eval "$(rbenv init -)"
