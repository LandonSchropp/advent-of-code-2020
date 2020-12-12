require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

VALID_FIELDS = %w(byr iyr eyr hgt hcl ecl pid).freeze

def valid_field?(key, value)
  case key
  when "byr" then /\A\d{4}\z/ =~ value && value.to_i.between?(1920, 2002)
  when "iyr" then /\A\d{4}\z/ =~ value && value.to_i.between?(2010, 2020)
  when "eyr" then /\A\d{4}\z/ =~ value && value.to_i.between?(2020, 2030)
  when "hgt"
    bounds = value[-2..] == "cm" ? [ 150, 193 ] : [ 59, 76 ]
    /\A\d+(cm|in)\z/ =~ value && value[0..-3].to_i.between?(*bounds)
  when "hcl" then /\A#[0-9a-f]{6}\z/ =~ value
  when "ecl" then %w(amb blu brn gry grn hzl oth).include?(value)
  when "pid" then /\A\d{9}\z/ =~ value
  else true
  end
end

def valid?(hash)
  (VALID_FIELDS - hash.keys).empty? && hash.all? { valid_field?(_1, _2) }
end

puts IO
  .read(ARGV[0])
  .split("\n\n")
  .map { _1.split(/\s+/).map { |item| item.split(":") }.to_h }
  .count { valid?(_1) }
