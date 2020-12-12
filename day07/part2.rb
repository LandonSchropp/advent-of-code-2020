require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path color))

def count_bags(graph, key, cache)
  return cache[key] if cache.key?(key)

  result = graph[key]
    .map { _1 + _1 * count_bags(graph, _2, cache) }
    .sum

  cache[key] = result
end

graph = IO
  .read(ARGV[0])
  .split("\n")
  .map do |rule|
    key = /(\D+?) bag/.match(rule)[1]

    values = rule
      .gsub("no other bags", "")
      .split("bag")
      .map { /(\d+) (.+)/.match(_1) }
      .compact
      .map do
        count, color = _1.captures.map(&:strip)
        [ count.to_i, color ]
      end

    [ key, values ]
  end
  .to_h

cache = {}

puts count_bags(graph, ARGV[1], cache)
