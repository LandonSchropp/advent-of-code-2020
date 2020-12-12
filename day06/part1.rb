require "set"
require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

puts IO
  .read(ARGV[0])
  .split("\n\n")
  .map do |answers|
    answers
      .split("\n")
      .map { _1.split("") }
      .reduce { _1 & _2 }
      .length
  end
  .sum
