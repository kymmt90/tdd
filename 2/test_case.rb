class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    public_send(name)
  end
end
