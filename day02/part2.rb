require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

puts IO
  .read(ARGV[0])
  .split("\n")
  .map { /(\d+)-(\d+) (.): (.*)/.match(_1).captures }
  .count { (_4[_1.to_i - 1] == _3) ^ (_4[_2.to_i - 1] == _3) }
