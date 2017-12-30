require 'fileutils'
require 'yaml'

include FileUtils

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
    powerline-status==2.4
  ).each do |text|
    sh "pip install #{text}"
  end
end

desc 'tools install by gem'
task :install_by_gem do
  %w(
    tmuxinator
  ).each do |text|
    sh "gem install #{text}"
  end
end

desc 'rbenv'
task :rbenv do
  puts "==== go-get to get rbenv ===="
  %w(
    github.com/rbenv/rbenv
    github.com/rbenv/ruby-build
    github.com/rbenv/rbenv-default-gems
  ).each do |text|
    system "go get #{text}"
  end

  puts "==== symlink .rbenv/plugins/ruby-build to rbenv/ruby-build ===="
  sh 'mkdir -p ~/.rbenv/plugins'
  home   = ENV.fetch('HOME'){ abort('You should set $HOME') }
  gopath = ENV.fetch('GOPATH'){ abort('You should set $GOPATH') }
  unless File.exist?("#{home}/.rbenv/plugins/ruby-build")
    ln_s "#{gopath}/src/github.com/rbenv/ruby-build", "#{home}/.rbenv/plugins"
  end

  unless File.exist?("#{home}/.rbenv/plugins/rbenv-default-gems")
    ln_s "#{gopath}/src/github.com/rbenv/rbenv-default-gems", "#{home}/.rbenv/plugins"
  end

  puts "==== default gem by rbenv-default-gems ===="

  File.write("#{home}/.rbenv/default-gems", %w[
             bundler
             pry
             ].join("\n"))
end

desc 'setup ruby'
task :ruby do
  sh 'rbenv install 2.4.1'
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
  puts "==== symlink to dotfiles ===="
  home = ENV.fetch('HOME'){ abort('You should set $HOME') }
  paths = `git ls-files`.split("\n").map{|p| p.split("/").first}.uniq - ["Rakefile"]
  paths.each do |path|
    link = "#{home}/#{path}"
    ln_s "#{Dir.pwd}/#{path}", link unless File.exist?(link)
  end
end

desc 'set up init.vim'
task :init_vim do
  home = ENV.fetch('HOME'){ abort('You should set $HOME') }
  mkdir_p "#{home}/.config/nvim"
  link = "#{home}/.config/nvim/init.vim"
  ln_s "#{Dir.pwd}/.config/nvim/init.vim", link unless File.exist?(link)
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

desc 'Install fonts for powerline'
task :fonts_powerline do
  sh 'go get github.com/powerline/fonts || true'
  Dir.chdir "#{ENV['GOPATH']}/src/github.com/powerline/fonts" do
    sh './install.sh'
  end
end

task :iceberg do
  sh 'go get github.com/cocopon/iceberg.vim || true'
  sh 'ln -s ~/go/src/github.com/cocopon/iceberg.vim/colors/iceberg.vim /usr/local/share/nvim/runtime/colors/iceberg.vim'
end

desc 'install docker'
task :docker do
  puts 'use docker-for-mac'
  puts 'visit https://docs.docker.com/docker-for-mac/'
end

desc 'install solarized to macvim'
task :solarized_macvim do
  SOLARIZED_DOWNLOAD_LOCATION = 'http://ethanschoonover.com/solarized/files/solarized.zip'
  MACVIM_COLORS_DIR = '/Applications/MacVim.app/Contents/Resources/vim/runtime/colors/'
  SOLARIZED_VIM_LOCATION = './solarized/vim-colors-solarized/colors/solarized.vim'

  Dir.chdir '/tmp' do
    rm_rf 'solarized'
    rm_rf 'solarized.zip'
    sh "curl -LO #{SOLARIZED_DOWNLOAD_LOCATION}"
    sh 'unzip -q solarized.zip'
    mv SOLARIZED_VIM_LOCATION, MACVIM_COLORS_DIR
    rm_rf 'solarized'
    rm_rf 'solarized.zip'
  end
end

desc 'install ecs-cli'
task :install_ecs_cli do
  Dir.chdir '/tmp' do
    ECS_CLI_LOCATION = 'https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-darwin-amd64-latest'
    ECS_CLI_MD5 = 'https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-darwin-amd64-latest.md5'
    sh "curl -sSL #{ECS_CLI_LOCATION} > ecs-cli"
    expected_md5 = %x(curl -sSL #{ECS_CLI_MD5})
    actual_md5   = %x(md5 -q ecs-cli)
    if expected_md5 == actual_md5
      chmod 0755, 'ecs-cli'
      mv 'ecs-cli', '/usr/local/bin'
    else
      abort 'md5 mismatch'
    end
  end
end
