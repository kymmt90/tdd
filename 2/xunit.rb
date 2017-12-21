class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    result = TestResult.new
    result.test_started
    set_up
    public_send(name)
    tear_down
    result
  end

  def set_up
  end

  def tear_down
  end
end

class TestResult
  def initialize
    @run_count = 0
  end

  def summary
    return "#{@run_count} run, 0 failed"
  end

  def test_started
    @run_count = @run_count + 1
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

  def test_broken_method
    raise StandardError
  end
end

class TestCaseTest < TestCase
  def test_template_method
    test = WasRun.new('test_method')
    test.run
    expect = 'set_up test_method tear_down'
    raise "expect #{expect}, actual #{test.log}" unless test.log == expect
  end

  def test_result
    test = WasRun.new('test_method')
    result = test.run
    expect = '1 run, 0 failed'
    raise "expect #{expect}, actual #{result.summary}" unless result.summary == expect
  end

  def test_failed_result
    test = WasRun.new('test_broken_method')
    result = test.run
    expect = '1 run, 1 failed'
    raise "expect #{expect}, actual #{result.summary}" unless result.summary == expect
  end
end

TestCaseTest.new('test_template_method').run
TestCaseTest.new('test_result').run
# TestCaseTest.new('test_failed_result').run
