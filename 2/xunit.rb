class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    set_up
    public_send(name)
  end

  def set_up
  end
end

class WasRun < TestCase
  attr_reader :was_run, :was_set_up

  def set_up
    @was_run = nil
    @was_set_up = 1
  end

  def test_method
    @was_run = 1
  end
end

class TestCaseTest < TestCase
  def set_up
    @test = WasRun.new('test_method')
  end

  def test_running
    @test.run
    raise 'assert' if @test.was_run == nil
  end

  def test_set_up
    @test.run
    raise 'assert' unless @test.was_set_up
  end
end

TestCaseTest.new('test_running').run
TestCaseTest.new('test_set_up').run
