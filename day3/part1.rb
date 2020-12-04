require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

SLOPE = 3

puts IO
  .read(ARGV[0])
  .split("\n")
  .map.with_index { _1[_2 * SLOPE % _1.length] }
  .count { _1 == "#" }
