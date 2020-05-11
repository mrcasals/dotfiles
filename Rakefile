require 'rake'
require 'erb'

def path_files(path)
  FileList[path].include(".*").exclude(".", "..")
end

excludes = %w(
  RakeFile
  *.itermcolors
  Readme*
  .config
  .git
  zsh
)

desc "install the dot files into user's home directory"
task :install do
  create_local_config_file("zshrc")
  create_local_config_file("gitconfig")

  path_files(".").exclude(excludes).each do |file|
    next if %w[config Rakefile Readme.md itermcolors].include? file

    link_file(file)
  end

  system "mkdir -p ~/.config"
  path_files(".config").each do |file|
    link_file(file)
  end
end

def link_file(file)
  puts "linking ~/#{file}"
  system %Q{ln -fs "$PWD/#{file}" "$HOME/#{file}"}
end

def create_local_config_file(file_name)
  puts "Creating ~/.#{file_name}.local"
  system %Q{touch "$HOME/.#{file_name}.local"}
end
