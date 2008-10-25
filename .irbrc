#-*-mode:ruby;-*-
%w{
    irb/completion
    rubygems
    wirble
    map_by_method
    what_methods
    pp
    english
}.each do |d|
  require d rescue nil
  puts "loaded #{d}"
end

wirble_opts = {
  :init_color => true,
}
Wirble.init
Wirble.colorize

require File.join(ENV['HOME'], '/src/towelie/lib/towelie.rb')

unless IRB.conf[:LOAD_MODULES].join =~ /config\/environment/
  require 'active_support'
end

# remember your hacks, gary
if !File.exists? Dir.pwd + '/script/console'
  puts "** remember the changed inferior-ruby-first-prompt-pattern in rinari.el:169 **"
end
load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']

%x{ stty -echo } if ENV['EMACS']

IRB.conf[:AUTO_INDENT] = true

# Setup permanent history.
HISTFILE = "~/.irb_history"
MAXHISTSIZE = 500
begin
  histfile = File::expand_path(HISTFILE)
  if File::exists?(histfile)
    lines = IO::readlines(histfile).collect { |line| line.chomp }
    puts "Read #{lines.nitems} saved history commands from '#{histfile}'." if $VERBOSE
    Readline::HISTORY.push(*lines)
  else
    puts "History file '#{histfile}' was empty or non-existant." if $VERBOSE
  end
  Kernel::at_exit do
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.nitems > MAXHISTSIZE
    puts "Saving #{lines.length} history lines to '#{histfile}'." if $VERBOSE
    File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
  end
end

class Object
  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    obj.methods(false).sort
  end
end

def time(times = 1)
  require 'benchmark'
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end
