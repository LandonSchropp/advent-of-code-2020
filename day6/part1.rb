require "set"
require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

puts IO
  .read(ARGV[0])
  .split("\n\n")
  .map { Set.new(_1.gsub(/\s+/, "").split("")).length }
  .sum
