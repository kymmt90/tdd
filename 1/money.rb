require_relative 'expression'
require_relative 'sum'

class Money
  attr_reader :amount, :currency

  include Expression

  def self.dollar(amount)
    Money.new(amount, 'USD')
  end

  def self.franc(amount)
    Money.new(amount, 'CHF')
  end

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{amount} #{currency}"
  end

  def reduce(bank, to)
    rate = bank.rate(currency, to)
    Money.new(amount / rate, to)
  end

  def ==(money)
    amount == money.amount && currency == money.currency
  end

  def +(addend)
    Sum.new(self, addend)
  end

  def *(multiplier)
    Money.new(amount * multiplier, currency)
  end
end
