class Day6
  @input = Array(Int64).new(9, 0)

  def initialize(f : String)
    File.read(f).split(",").map(&.to_i).tally.each { |k, v| @input[k] = v.to_i64 }
  end

  def sum_fish(fish, x)
    x.times { |i| fish[(i + 7) % 9] += fish[i % 9] }
    fish.sum
  end

  def part1
    sum_fish(@input.clone, 80)
  end

  def part2
    sum_fish(@input.clone, 256)
  end
end
