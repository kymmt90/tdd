class Money
  attr_reader :amount, :currency

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

  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end

  def ==(money)
    amount == money.amount && currency == money.currency
  end

  def +(money)
    Money.new(amount + money.amount, currency)
  end
end
