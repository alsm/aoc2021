class Day2
@input : Array(Tuple(String, Int32))

  def initialize(f : String)
    @input = File.read_lines(f).map(&.split).map { |l| {l[0], l[1].to_i32} }
  end

  def part1
    @input.reduce([0, 0]) do |(pos, depth), (d, v)|
    d == "forward" ? [pos + v, depth] : d == "down" ? [pos, depth + v] : [pos, depth - v]
    end.product
  end

  def part2
    @input.reduce([0, 0, 0]) do |(aim, pos, depth), (d, v)|
    d == "forward" ? [aim, pos + v, depth + aim * v] : d == "down" ? [aim + v, pos, depth] : [aim - v, pos, depth]
    end.[1..2].product
  end
end
