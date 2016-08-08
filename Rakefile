require 'fileutils'
desc 'go!'
task :install do

  #sh 'echo xcode-select --intall'

  #sh 'echo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

  #sh 'brew doctor'

  %w(
  git
  gnu-sed
  gnu-tar
  go
  heroku-toolbelt
  hub
  jq
  lha
  nodenv
  nkf
  peco
  pwgen
  qt
  reattach-to-user-namespace
  tmux
  tree
  vim
  watch
  wget
  z
  zsh
  ).each do |text|
    sh "brew install #{text}"
  end

  %w(
  apple-gcc42
  autoconf
  bindfs
  boot2docker
  chruby
  coreutils
  dnvm
  docker
  graphviz
  icu4c
  ipcalc
  libevent
  libpng
  maven31
  mercurial
  mono
  mysql
  n
  nginx
  openssl
  osxfuse
  pcre
  pkg-config
  postgresql
  readline
  redis
  ruby-build
  the_silver_searcher
  xz
  ).each do |text|
    puts "not install : brew install #{text}"
  end

  %w(
    clipmenu
    google-chrome
    google-japanese-ime
    karabiner
    macvim
    skitch
    vagrant
  ).each do |text|
    sh "brew cask install #{text}"
  end
  # licecap
end

desc 'rbenv'
task :rbenv do
  puts "==== go-get to get rbenv ===="
  %w(
    github.com/rbenv/rbenv
    github.com/rbenv/ruby-build
  ).each do |text|
    system "go get #{text}"
  end

  puts "==== symlink .rbenv/plugins/ruby-build to rbenv/ruby-build ===="
  sh 'mkdir -p ~/.rbenv/plugins'
  include FileUtils
  home   = ENV.fetch('HOME'){ abort('You should set $HOME') }
  gopath = ENV.fetch('GOPATH'){ abort('You should set $GOPATH') }
  unless File.exist?("#{home}/.rbenv/plugins/ruby-build")
    ln_s "#{gopath}/src/github.com/rbenv/ruby-build", "#{home}/.rbenv/plugins"
  end
end

desc 'setup ruby'
task :ruby do
  sh 'rbenv install 2.3.1'
end

desc 'setup ssh client'
task :ssh do
  puts "==== setup ~/.ssh ===="
  sh 'mkdir -p .ssh'
  sh 'chmod 700 .ssh'
  unless File.exist?('.ssh/id_rsa')
    puts 'Not Found -- .ssh/id_rsa'
  end
end

desc 'symlink to dotfiles'
task :symlink do
  include FileUtils
  puts "==== symlink to dotfiles ===="
  home = ENV.fetch('HOME'){ abort('You should set $HOME') }
  paths = `git ls-files`.split("\n").map{|p| p.split("/").first}.uniq - ["Rakefile"]
  paths.each do |path|
    link = "#{home}/#{path}"
    ln_s "#{Dir.pwd}/#{path}", link unless File.exist?(link)
  end
end

desc 'login shell'
task :login_shell do
  puts "==== how to change login shell ===="
  puts "「ユーザとグループ」->"
  puts "「hoshino」-> 右クリック -> 詳細オプション"
end

desc 'neobundle'
task :neobundle do
  puts "You should install neobundle for vim setup."
  puts "Visit github.com/Shougo/neobundle.vim"
end
