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
  hub
  jq
  lha
  nodenv
  nkf
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
    sh "echo brew install #{text}"
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
  z
  ).each do |text|
    puts "not install : brew install #{text}"
  end
end

%w(
  clipmenu
  google-chrome
  google-japanese-ime
  karabiner
  skitch
  vagrant
).each do |text|
  sh "brew cask install #{text}"
end
  # licecap
