require "test/unit"
require File.expand_path("../../lib/retroactive_module_inclusion", __FILE__)

[1,2].each do |n|
  eval <<-EOS
    module Stats#{n}
      def mean#{n}
        inject(&:+) / count.to_f
      end
    end
  EOS
end

class TestRetroactiveInclude < Test::Unit::TestCase

  def test_argument_type
    type_error(Enumerable, Array)
    type_error(Comparable, Range)
    type_error(Math, Numeric)
    type_ok(Array, Enumerable)
    type_ok(Range, Comparable)
    type_ok(Numeric, Math)
  end
  
  def test_retroactively_include_private
    assert_raise(NoMethodError) { (1..2).mean1 }
    Enumerable.module_eval { include Stats1 }
    assert_raise(NoMethodError, 'include should not work retroactively ') { (1..2).mean1 }
    Enumerable.module_eval { retroactively_include Stats1 }
    assert_nothing_raised('retroactively_include should do the job') { (1..2).mean1 }
    assert_equal 1.5, (1..2).mean1
  end
  
  def test_retroactively_include_public
    assert_raise(NoMethodError) { (1..2).mean2 }
    Enumerable.module_eval { include Stats2 }
    assert_raise(NoMethodError, 'include should not work retroactively ') { (1..2).mean2 }
    Enumerable.module_eval { retroactively_include Stats2 }
    assert_nothing_raised('retroactively_include should do the job') { (1..2).mean2 }
    assert_equal 1.5, (1..2).mean2
  end
  
  def test_jruby_object_space_prev_state
    if defined?(RUBY_DESCRIPTION) && RUBY_DESCRIPTION =~ /jruby/i
      require 'jruby'
      [true, false].each do |prev_state|
        JRuby.objectspace = prev_state
        Enumerable.module_eval { include Stats1 }
        assert_equal prev_state, JRuby.objectspace
      end
    end
  end
  
  private
  
  def type_error(a, b)
    assert_raise(TypeError, 'shold raise TypeError for non Module inclusion') do
      a.module_eval { retroactively_include b }
    end
  end
  
  def type_ok(a, b)
    assert_nothing_raised('shold not raise Exception for Module inclusion') do
      a.module_eval { retroactively_include b }
    end
  end
  
end

