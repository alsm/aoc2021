class Day9
  property input : Hash(Tuple(Int32, Int32), Int32)

  def initialize(f : String)
    @input = Hash(Tuple(Int32, Int32), Int32).new
    File.read_lines(f).map(&.chars.map(&.to_i32)).each_with_index do |l, i|
      l.each_with_index do |v, j|
        @input[{j, i}] = v
      end
    end
  end

  def is_low?(x, y, v)
    [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].map { |(dx, dy)| input[{dx + x, dy + y}]? }.compact.reduce(true) { |acc, s| acc &&= v < s }
  end

  def neighbours(x, y)
    [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].map { |(dx, dy)| {dx + x, dy + y} }.map { |p| @input[p]? && @input[p] < 9 ? p : nil }.compact
  end

  def part1
    input.select { |(x, y), v| is_low?(x, y, v) }.values.map(&.+(1)).sum
  end

  def part2
    input.select { |(x, y), v| is_low?(x, y, v) }.map do |p, _|
      seen = [p]
      find = Deque.new(neighbours(*p))
      while l = find.shift?
        seen << l
        find.concat(neighbours(*l) - seen)
      end
      seen.uniq.size
    end.sort.pop(3).product
  end
end
