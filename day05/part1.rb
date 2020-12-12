require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

def seat_id(seat_code)
  row = seat_code[0..6].gsub(/./, { "F" => "0", "B" => "1" }).to_i(2)
  column = seat_code[-3..].gsub(/./, { "L" => "0", "R" => "1" }).to_i(2)
  row * 8 + column
end

puts IO
  .read(ARGV[0])
  .split("\n")
  .map { seat_id(_1) }
  .max
