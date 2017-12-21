class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    set_up
    public_send(name)
    tear_down
  end

  def set_up
  end

  def tear_down
  end
end

class WasRun < TestCase
  attr_reader :log

  def set_up
    @log = __method__.to_s
  end

  def tear_down
    @log << " #{__method__.to_s}"
  end

  def test_method
    @log << " #{__method__.to_s}"
  end
end

class TestCaseTest < TestCase
  def test_template_method
    test = WasRun.new('test_method')
    test.run
    expect = 'set_up test_method tear_down'
    raise "expect #{expect}, actual #{test.log}" unless test.log == expect
  end
end

TestCaseTest.new('test_template_method').run
