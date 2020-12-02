puts IO
  .read(ARGV.first)
  .split("\n")
  .map(&:to_i)
  .combination(2)
  .to_a
  .find { _1 + _2 == 2020 }
  .then { _1 * _2 }
