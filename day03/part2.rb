require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

SLOPES = [ [ 1, 1 ], [ 3, 1 ], [ 5, 1 ], [ 7, 1 ], [ 1, 2 ] ].freeze

def number_of_trees(slope_x, slope_y)
  IO
    .read(ARGV[0])
    .split("\n")
    .each_slice(slope_y)
    .map(&:first)
    .map.with_index { _1[_2 * slope_x % _1.length] }
    .count { _1 == "#" }
end

puts SLOPES.map { number_of_trees(*_1) }.reduce(&:*)
