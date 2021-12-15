class Day5
  class Line
    include Enumerable(Tuple(Int32, Int32))
    property p1x, p1y, p2x, p2y : Int32

    def initialize(@p1x : Int32, @p1y : Int32, @p2x : Int32, @p2y : Int32)
    end

    def each
      x1, y1, x2, y2 = p1x, p1y, p2x, p2y

      dx, dy = x2 > x1 ? 1 : -1, y2 > y1 ? 1 : -1
      dx = 0 if x1 == x2
      dy = 0 if y1 == y2

      while x1 != x2 || y1 != y2
        yield ({x1, y1})
        x1, y1 = x1 + dx, y1 + dy
      end
      yield ({x1, y1})
    end
  end

  @input : Array(Line)

  def initialize(f : String)
    @input = File.read_lines(f).map(&.gsub(" -> ", ",")).map { |l| n = l.split(",").map(&.to_i); Line.new(n[0], n[1], n[2], n[3]) }
  end

  def part1
    @input.select { |l| l.p1x == l.p2x || l.p1y == l.p2y }.map(&.to_a).flatten.tally.select { |k, v| v > 1 }.size
  end

  def part2
    @input.map(&.to_a).flatten.tally.select { |k, v| v > 1 }.size
  end
end
