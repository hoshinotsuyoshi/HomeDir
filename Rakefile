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

desc 'tools install by pip3'
task :install_by_pip3 do
  %w(
    powerline-status==2.4
  ).each do |text|
    sh "pip3 install #{text} --user"
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
             pry
             neovim
             ].join("\n"))
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
