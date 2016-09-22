require 'fileutils'
require 'yaml'

def setting
  yaml = File.join(File.dirname(__FILE__), 'setting.yml')
  YAML.load_file(yaml)
end

desc 'xcode-select --install'
task :xcode_select_install do
  sh 'xcode-select --install'
end

desc 'install homebrew'
task :brew do
  sh '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

  sh 'brew doctor'
end

desc 'install commands by homebrew and homebrew-cask'
task :install do

  setting[:brew].each do |text|
    sh "brew install #{text}"
  end

  setting[:cask].each do |text|
    sh "brew cask install #{text}"
  end
  # licecap
end

desc 'tools install by pip'
task :install_by_pip do
  %w(
    awscli
    awslogs
  ).each do |text|
    sh "pip install #{text}"
  end
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

desc 'setup karabiner'
task :karabiner do
  puts "==== replace private.xml ===="
  include FileUtils
  cp 'karabiner/private.xml',
    "/Users/hoshino/Library/Application Support/Karabiner"
  puts "!!!"
  puts "replacing private.xml is successful. Please open karabiner && do reload xml."
  puts "!!!"
end

desc 'show chrome extention'
task :chrome_extention do
  puts "==== show favorite extensions ===="
  puts %w(
    https://chrome.google.com/webstore/detail/vichrome/gghkfhpblkcmlkmpcpgaajbbiikbhpdi
    https://chrome.google.com/webstore/detail/githubexpandinizr/cbehdjjcilgnejbpnjhobkiiggkedfib
  )
end

desc 'show fonts'
task :fonts do
  puts "==== show favorite fonts ===="
  puts %w(
    inconsolata
  )
end

desc 'install docker'
task :docker do
  puts 'use docker-for-mac'
  puts 'visit https://docs.docker.com/docker-for-mac/'
end
