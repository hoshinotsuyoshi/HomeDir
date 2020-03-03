alias ll='ls -alF'
alias ctags="`brew --prefix`/bin/ctags"
##alias rspec='(){ rspec "$*" ; say "アールスペックが終わりました" }'

### go
if [ -x "`which go`" ]; then
      export GOPATH=$HOME/go
      export PATH=$PATH:$GOPATH/bin
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Added by the Heroku Toolbelt
export EDITOR="vim"

#左のほうにユーザ名とカレントディレクトリを表示するPROMPT
# PROMPT='[%F{blue}%d%f]$ '
PROMPT='[%F{blue}%15>..>%c%<<%f]$ '

# http://futurismo.biz/archives/1363
## Screenでのコマンド共有用
## シェルを横断して.zshhistoryに記録
setopt inc_append_history
## ヒストリを共有
setopt share_history

# 自動補完を有効にする
# コマンドの引数やパス名を途中まで入力して <Tab> を押すといい感じに補完してくれる
# 例： `cd path/to/<Tab>`, `ls -<Tab>`
autoload -U compinit; compinit -u

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd
# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

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

# emacs風。明示しないと^Pが使えない時ある
bindkey -e

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

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${GOPATH}/src/github.com/rbenv/rbenv/bin:${PATH} && \
    eval "$(rbenv init -)"

source ~/.tmuxinator/tmuxinator.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f /usr/local/google-cloud-sdk/path.zsh.inc ]; then
  source '/usr/local/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /usr/local/google-cloud-sdk/completion.zsh.inc ]; then
  source '/usr/local/google-cloud-sdk/completion.zsh.inc'
fi

PATH="/Users/hoshino/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/hoshino/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/hoshino/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/hoshino/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/hoshino/perl5"; export PERL_MM_OPT;

# gpg
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b
# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#     source ~/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
# fi

export DISABLE_AUTO_TITLE=true
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

alias v='nvim'
# alias g='git'
# alias rubocop='rubocop-daemon-wrapper'

eval "$(pyenv init -)"

# avoid brew-doctor warning
# https://qiita.com/takuya0301/items/695f42f6904e979f0152
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/hoshino/go/src/github.com/adventar/adventar/frontend/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/hoshino/go/src/github.com/adventar/adventar/frontend/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/hoshino/go/src/github.com/adventar/adventar/frontend/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/hoshino/go/src/github.com/adventar/adventar/frontend/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/hoshino/go/src/github.com/adventar/adventar/frontend/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/hoshino/go/src/github.com/adventar/adventar/frontend/node_modules/tabtab/.completions/slss.zsh