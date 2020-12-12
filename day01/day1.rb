require_relative "../shared/arguments.rb"

EXPECTED_RESULT = 2020

Arguments.validate!(%w(combination-size file-path))

puts IO
  .read(ARGV[1])
  .split("\n")
  .map(&:to_i)
  .combination(ARGV[0].to_i)
  .to_a
  .find { _1.sum == EXPECTED_RESULT }
  .then { _1.reduce(&:*) }
