class Day7
  property input : Array(Int32)

  def initialize(f : String)
    @input = File.read(f).split(",").map(&.to_i32).sort!
  end

  def part1
    input.map { |s| (input[input.size//2] - s).abs }.sum
  end

  def part2
    (input.min..input.max).map { |x| input.map { |s| (1..(x - s).abs).sum }.sum}.min
  end
end
