class Day3
  @input : Array(Array(Int32))

  def initialize(f : String)
    @input = File.read_lines(f).map(&.chars.map(&.to_i))
  end

  def part1
    @input.transpose.map { |l| l.count(1) >= l.count(0) ? [1, 0] : [0, 1] }.transpose.map(&.join).map(&.to_i(2)).product
  end

  def part2
    o2 = @input.clone
    (0...o2[0].size).each do |i|
      common = o2.map(&.[i]).count(1) >= o2.map(&.[i]).count(0) ? 1 : 0
      o2.select! { |l| l[i] == common }
      break if o2.size == 1
    end
    co2 = @input.clone
    (0...co2[0].size).each do |i|
      common = co2.map(&.[i]).count(0) <= co2.map(&.[i]).count(1) ? 0 : 1
      co2.select! { |l| l[i] == common }
      break if co2.size == 1
    end
    o2[0].join.to_i(2) * co2[0].join.to_i(2)
  end
end
