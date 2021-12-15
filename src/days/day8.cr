class Day8
  @output : Array(Array(Array(Char)))
  @mapped : Array(Hash(Array(Char), Int32))

  def initialize(f : String)
    input = File.read_lines(f).map(&.split(" | ")).map(&.[0]).map(&.split).map(&.map(&.chars.sort))
    @output = File.read_lines(f).map(&.split(" | ")).map(&.[1]).map(&.split).map(&.map(&.chars.sort))
    @mapped = input.map { |l| find_numbers(l) }
  end

  def find_numbers(l)
    m = {
      1 => l.find([] of Char) { |e| e.size == 2 },
      8 => l.find([] of Char) { |e| e.size == 7 },
      7 => l.find([] of Char) { |e| e.size == 3 },
      4 => l.find([] of Char) { |e| e.size == 4 },
    }
    m[3] = (l - m.values).find([] of Char) { |e| e.size == 5 && (m[8] - e - m[1]).size == 2 }
    m[5] = (l - m.values).find([] of Char) { |e| e.size == 5 && (e - m[4]).size == 2 }
    m[6] = (l - m.values).find([] of Char) { |e| e.size == 6 && (e - m[7]).size == 4 }
    m[9] = (l - m.values).find([] of Char) { |e| e.size == 6 && (e - m[5]).size == 1 }
    m[0] = (l - m.values).find([] of Char) { |e| e.size == 6 }
    m[2] = (l - m.values).find([] of Char) { |e| e.size == 5 }
    m.invert
  end

  def part1
    @output.map_with_index do |v, i|
      v.map { |e| @mapped[i][e] }.select { |l| [1, 4, 7, 8].any?(l) }
    end.flatten.size
  end

  def part2
    @output.map_with_index do |v, i|
      v.map { |e| @mapped[i][e] }.join.to_i32
    end.sum
  end
end
