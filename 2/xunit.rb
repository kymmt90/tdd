require_relative 'was_run'

test = WasRun.new('test_method')
p test.was_run
test.run
p test.was_run
