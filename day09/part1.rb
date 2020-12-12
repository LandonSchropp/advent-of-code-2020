require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

puts IO
  .read(ARGV[0])
  .split("\n")
  .map(&:to_i)
  .each_cons(26)
  .find { |subset| !subset[0..-2].product(subset[0..-2]).any? { _1 + _2 == subset[-1] } }
  .last
