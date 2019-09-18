# IRBRC file by Iain Hecker, http://iain.nl
# put all this in your ~/.irbrc
require 'rubygems'
require 'yaml'
require 'irb/completion'

alias q exit

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
  def do(&block)
    block.call self
  end
end

ANSI = {}
ANSI[:RESET]     = "\e[0m"
ANSI[:BOLD]      = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY]     = "\e[0;37m"
ANSI[:GRAY]      = "\e[1;30m"
ANSI[:RED]       = "\e[31m"
ANSI[:GREEN]     = "\e[32m"
ANSI[:YELLOW]    = "\e[33m"
ANSI[:BLUE]      = "\e[34m"
ANSI[:MAGENTA]   = "\e[35m"
ANSI[:CYAN]      = "\e[36m"
ANSI[:WHITE]     = "\e[37m"

# Improve the `:SIMPLE` irb prompt with colors
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  :PROMPT_I => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_N => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
  :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
  :RETURN   => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
  :AUTO_INDENT => true }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR
IRB.conf[:EVAL_HISTORY] = 200
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irb_history"

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, highlighted = true, required = false)
  require name if required
  yield if block_given?

  if highlighted
    $console_extensions << "#{ANSI[:BLUE]}#{name}#{ANSI[:RESET]}"
  else
    $console_extensions << "#{ANSI[:YELLOW]}#{name}#{ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{ANSI[:RED]}#{name}#{ANSI[:RESET]}"
end
$console_extensions = []

extend_console "autocompletion"
extend_console "session_history"
extend_console "global_history"

# Add a method pm that shows every method on an object
# Pass a regex to filter these
extend_console 'pm' do
  def pm(obj, *options) # Print methods
    methods = obj.methods
    methods -= Object.methods unless options.include? :more
    filter  = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = obj.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name.to_s, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI[:YELLOW]}#{item[0].to_s.rjust(max_name)}#{ANSI[:RESET]}"
      print "#{ANSI[:BLUE]}#{item[1].ljust(max_args)}#{ANSI[:RESET]}"
      print "   #{ANSI[:GRAY]}#{item[2]}#{ANSI[:RESET]}\n"
    end
    data.size
  end
end

extend_console "h", false do
  def h(extension_name = :h)
    case extension_name
    when :h
      print <<~DOC
      # USAGE: `h(extension_name)`.
      #
      # Prints docs for a given console extension.
      DOC
    when :pm
      print <<~DOC
        # pm(obj, *options)
        #
        # Lists the methods for the given object. By default, all
        # `Object.methods` are omitted.
        #
        # obj - the object to debug
        # options - a list of extra options. Available options are:
        #   <a regexp> - lists only the methods matching the regexp
        #   :more - Outputs all public methods from the object.
      DOC
    when :session_history
      print <<~DOC
      # Use `__` (double underscore) to list all the session return values
      # used. You can use `__[2]` to get the 2nd returned value, or `__[-2]` to
      # get the previous-to-last returned value.
      DOC
    when :global_history
      print <<~DOC
      # Use <UP> and <DOWN> keys to navigate global IRb history. It's
      # cross-session.
      DOC
    when :autocompletion
      print <<~DOC
      # 1.neg<tab> => 1.negative?
      #
      # Autocompletes the current word with known methods and variables.
      DOC
    else
      system("ri", extension_name.to_s)
    end
    print "\n"
  end
end

# Show results of all extension-loading
puts "#{ANSI[:LGRAY]}~> Console extensions:#{ANSI[:RESET]} #{$console_extensions.join(' ')}#{ANSI[:RESET]}"
