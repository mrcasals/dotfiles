require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  create_local_config_file("zshrc")
  create_local_config_file("gitconfig")

  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc Readme.rdoc LICENSE zsh].include? file

    link_file(file)
  end

  system('cat zshrc >> ~/.zshrc')
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def create_local_config_file(file_name)
  puts "Creating ~/.#{file_name}.local"
  system %Q{touch "$HOME/.#{file_name}.local"}
end
