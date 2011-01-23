module CoreExt
  module Module
    module RetroactiveModuleInclusion

      # Includes +mod+ retroactively, i.e., extending to all classes and modules which
      # had included +self+ _beforehand_.
      #
      # @example Retroactively include a module in Enumerable.
      #
      #   module Stats
      #     def mean
      #       inject(&:+) / count.to_f
      #     end
      #   end
      #
      #   Enumerable.module_eval { retroactively_include Stats }
      #
      #   (1..2).mean  #=>  1.5
      #
      # @return self
      #
      def retroactively_include(mod)
        raise TypeError, "wrong argument type #{mod.class} (expected Module)" unless mod.is_a? ::Module # ::Module would in general be equivalent to Object::Module and simply Module would mean CoreExt::Module in this context
        
        pseudo_descendants.each do |pd|
          pd.module_eval { include mod }
        end
        
        self
      end
      
      private
      
      # @return [Array] All modules and classes which have self in its ancestors tree, including self itself.
      #
      def pseudo_descendants
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
        result = []
        ObjectSpace.each_object(::Module) do |m|
          if m <= self # equiv. to "if m.include?(self) || m == self"
            result << m
          end
        end
        if defined?(RUBY_DESCRIPTION) && RUBY_DESCRIPTION =~ /jruby/i
          JRuby.objectspace = prev_jruby_objectspace_state
        end
        result
      end
      
      ::Module.class_eval { include CoreExt::Module::RetroactiveModuleInclusion }
  
    end
  end
end

