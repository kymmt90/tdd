module Expression
  def reduce(bank, to)
    raise NotImplementedError
  end

  def +(addend)
    raise NotImplementedError
  end

  def *(multiplier)
    raise NotImplementedError
  end
end
