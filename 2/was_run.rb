require_relative 'test_case'

class WasRun < TestCase
  attr_reader :was_run

  def initialize(name)
    super(name)
    @was_run = nil
  end

  def test_method
    @was_run = 1
  end
end
