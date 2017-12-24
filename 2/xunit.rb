class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run(result)
    result.test_started
    set_up
    public_send(name) rescue result.test_failed
    tear_down
  end

  def set_up
  end

  def tear_down
  end
end

class TestResult
  def initialize
    @run_count = 0
    @error_count = 0
  end

  def summary
    return "#{@run_count} run, #{@error_count} failed"
  end

  def test_started
    @run_count = @run_count + 1
  end

  def test_failed
    @error_count = @error_count + 1
  end
end

class TestSuite
  def initialize
    @tests = []
  end

  def add(test)
    @tests << test
  end

  def run(result)
    @tests.each { |test| test.run(result) }
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
  attr_reader :result

  def set_up
    @result = TestResult.new
  end

  def test_template_method
    test = WasRun.new('test_method')
    test.run(result)
    expect = 'set_up test_method tear_down'
    raise "expect #{expect}, actual #{test.log}" unless test.log == expect
  end

  def test_result
    test = WasRun.new('test_method')
    test.run(result)
    expect = '1 run, 0 failed'
    raise "expect #{expect}, actual #{result.summary}" unless result.summary == expect
  end

  def test_failed_result
    test = WasRun.new('test_broken_method')
    test.run(result)
    expect = '1 run, 1 failed'
    raise "expect #{expect}, actual #{result.summary}" unless result.summary == expect
  end

  def test_failed_result_formatting
    result.test_started
    result.test_failed
    expect = '1 run, 1 failed'
    raise "expect #{expect}, actual #{result.summary}" unless result.summary == expect
  end

  def test_suite
    suite = TestSuite.new
    suite.add(WasRun.new('test_method'))
    suite.add(WasRun.new('test_broken_method'))
    suite.run(result)
    expect = '2 run, 1 failed'
    raise "expect #{expect}, actual #{result.summary}" unless result.summary == expect
  end
end

suite = TestSuite.new
suite.add(TestCaseTest.new('test_template_method'))
suite.add(TestCaseTest.new('test_result'))
suite.add(TestCaseTest.new('test_failed_result'))
suite.add(TestCaseTest.new('test_failed_result_formatting'))
suite.add(TestCaseTest.new('test_suite'))
result = TestResult.new
suite.run(result)
puts result.summary
