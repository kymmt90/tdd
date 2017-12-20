require_relative 'test_case'
require_relative 'was_run'

class TestCaseTest < TestCase
  def test_running
    test = WasRun.new('test_method')
    raise 'assert' if test.was_run != nil
    test.run
    raise 'assert' if test.was_run == nil
  end
end

TestCaseTest.new('test_running').run
