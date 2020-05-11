require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  create_local_config_file("zshrc")
  create_local_config_file("gitconfig")

  Dir['*'].each do |file|
    next if %w[config Rakefile README Readme itermcolors LICENSE zsh].include? file

    link_file(file, ".")
  end

  system "mkdir -p ~/.config"
  Dir['.config/*'].each do |file|
    link_file(file, ".config/")
  end
end

def link_file(file, prefix)
  puts "linking ~/#{file}"
  system %Q{ln -fs "$PWD/#{file}" "$HOME/#{file}"}
end

def create_local_config_file(file_name)
  puts "Creating ~/.#{file_name}.local"
  system %Q{touch "$HOME/.#{file_name}.local"}
end
