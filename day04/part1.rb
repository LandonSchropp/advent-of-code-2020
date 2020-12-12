require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

VALID_FIELDS = %w(byr iyr eyr hgt hcl ecl pid).freeze

puts IO
  .read(ARGV[0])
  .split("\n\n")
  .map { _1.split(/\s+/).map { |item| item[0..2] } }
  .count { (VALID_FIELDS - _1).length.zero? }
