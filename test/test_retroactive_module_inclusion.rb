require "test/unit"
require File.expand_path("../../lib/retroactive_module_inclusion", __FILE__)

module Stats
  def mean
    inject(&:+) / count.to_f
  end
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
  
  def test_retroactively_include
    assert_raise(NoMethodError) { (1..2).mean }
    Enumerable.module_eval { include Stats }
    assert_raise(NoMethodError, 'include should not work retroactively ') { (1..2).mean }
    Enumerable.module_eval { retroactively_include Stats }
    assert_nothing_raised('retroactively_include should do the job') { (1..2).mean }
    assert_equal 1.5, (1..2).mean
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

