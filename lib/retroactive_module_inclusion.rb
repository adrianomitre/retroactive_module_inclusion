class Module

  private

  def retroactively_include(mod)
    raise TypeError, 'wrong argument type #{mod.class} (expected Module)' unless mod.is_a? Module

    # Although one would expect +A.module_eval("include B")+ to make methods
    # from module +B+ available to all classes and modules that had previously
    # included module +A+, this is not the case due to a limitation in Ruby's
    # object model (see [dynamic module include problem][1]). Thus, one has two
    # possible solutions:
    #   * use Module#include_retroactively instead of Module#include
    #   * reopen +A+ and define the methods directly inside it
    #
    # JRuby (at least up to version 1.5.6) has ObjectSpace disabled by default,
    # thus it must be enabled manually ([reference][2]).
    #
    # [1]: http://eigenclass.org/hiki/The+double+inclusion+problem                      "Dynamic Module Include Problem"
    # [2]: http://ola-bini.blogspot.com/2007/07/objectspace-to-have-or-not-to-have.html "ObjectSpace: to have or not to have"
    #
    prev_jruby_objectspace_state = nil # only for scope reasons
    if defined?(RUBY_DESCRIPTION) && RUBY_DESCRIPTION =~ /jruby/i
      require 'jruby'
      prev_jruby_objectspace_state = JRuby.objectspace
      JRuby.objectspace = true
    end
    ObjectSpace.each_object(Module) do |m|
      if m <= self # equiv. to "if m.include?(self) || m == self"
        m.module_eval { include mod }
      end
    end
    if defined?(RUBY_DESCRIPTION) && RUBY_DESCRIPTION =~ /jruby/i
      JRuby.objectspace = prev_jruby_objectspace_state
    end
  end
  
end