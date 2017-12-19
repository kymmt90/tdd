require_relative 'expression'

class Sum
  attr_reader :augend, :addend

  include Expression

  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def reduce(bank, to)
    amount = augend.amount + addend.amount
    Money.new(amount, to)
  end
end
