require "pry-byebug"
require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

def contiguous_end_index(numbers, target, index, sum)
  return index - 1 if sum == target
  return if sum > target
  contiguous_end_index(numbers, target, index + 1, sum + numbers[index])
end

def contiguous_range(numbers, target, index)
  range_end = contiguous_end_index(numbers, target, index, 0)
  numbers[index..range_end].sort.then { _1.min + _1.max } unless range_end.nil?
end

numbers = IO
  .read(ARGV[0])
  .split("\n")
  .map(&:to_i)

invalid_number = numbers
  .each_cons(26)
  .find { |subset| !subset[0..-2].product(subset[0..-2]).any? { _1 + _2 == subset[-1] } }
  .last

puts(
  (0...numbers.length)
    .map { contiguous_range(numbers, invalid_number, _1) }
    .find { !_1.nil? }
)
