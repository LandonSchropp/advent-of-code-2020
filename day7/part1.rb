require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path color))

def leads_to_color?(graph, key, destination, cache)
  return cache[key] if cache.key?(key)

  result = graph[key].include?(destination) || graph[key].any? do
    leads_to_color?(graph, _1, destination, cache)
  end

  cache[key] = result
end

graph = IO
  .read(ARGV[0])
  .split("\n")
  .map { |rule| rule.gsub("no other bags", "").scan(/\D+ bag/).map { _1.gsub(/bags?/, "").strip } }
  .map { [ _1[0], _1[1..] ] }
  .to_h

cache = {}

puts graph.keys.count { leads_to_color?(graph, _1, ARGV[1], cache) }
