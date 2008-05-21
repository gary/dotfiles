#-*-mode:ruby;-*-
%w{
    irb/completion
    rubygems
    wirble
    map_by_method
    what_methods
    pp
}.each do |d|
  require d rescue nil
  puts "loaded #{d}"
end

require 'wirble'

wirble_opts = {
  :init_color => true,
}
Wirble.init
Wirble.colorize

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
