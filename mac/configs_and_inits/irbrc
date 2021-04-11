require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history')
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Use awesome_print as the default formatter.
begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError
  puts 'awesome_print unavailable :('
end

class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

end

class Object
  def interesting_methods
    case self.class
    when Class;  self.public_methods.sort - Object.public_methods
    when Module; self.public_methods.sort - Module.public_methods
    else         self.public_methods.sort - Object.new.public_methods
    end
  end
end