require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

puts IO
  .read(ARGV[0])
  .split("\n")
  .map(&:to_i)
  .sort
  .then { [ 0, *_1, _1.last + 3 ] }
  .each_cons(2)
  .map { _2 - _1 }
  .tally
  .values
  .reduce(&:*)
