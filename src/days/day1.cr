class Day1
  property input : Array(Int32)

  def initialize(f : String)
    @input = File.read_lines(f).map &.to_i32
  end

  def part1
    @input.each.cons_pair.count { |(a, b)| b > a }
  end

  def part2
    @input.each.cons(3).cons_pair.select { |(a, b)| b.sum > a.sum }.size
  end
end
