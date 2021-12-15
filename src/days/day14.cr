class Day14
  property template : String
  property rules : Hash(String, String)

  def initialize(f : String)
    input = File.read_lines(f).reject!(&.empty?)
    @template = input[0]
    @rules = input[1..].map(&.split(" -> ")).to_h
  end

  def insert(t)
  end

  def part1
    count = (0..9).reduce(template) do |acc, i|
      acc = acc.chars.each_cons(2).map { |(a, b)| a = a.to_s; a + rules[a + b] }.join + template.[-1]
    end.chars.tally
    count.values.max - count.values.min
  end

  def part2
    rc = template.chars.each_cons(2).reduce(Hash(String, Int64).new(0)) { |acc, (a, b)| acc[a.to_s + b] += 1; acc }
    count = (0..39).reduce(rc) do |acc, i|
      acc.reduce(Hash(String, Int64).new(0)) { |acc, (k, v)| n = rules[k]; acc[k[0] + n] += v; acc[n + k[1]] += v; acc }
    end.group_by { |k, v| k[0] }.map { |k, v| {k, v.map(&.[1].to_i64).sum} }.to_h
    count[template[-1]] += 1
    count.values.max - count.values.min
  end
end

d = Day14.new("day14.txt")

pp d.part1
pp d.part2
