require_relative 'expression'

class Sum
  attr_reader :augend, :addend

  include Expression

  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def reduce(bank, to)
    amount = augend.reduce(bank, to).amount + addend.reduce(bank, to).amount
    Money.new(amount, to)
  end

  def +(addend)
    Sum.new(self, addend)
  end

  def *(multiplier)
    Sum.new(augend * 2, addend * 2)
  end
end
