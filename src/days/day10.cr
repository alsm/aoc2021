class Day10
  property input : Array(Array(Char))
  getter openers = ['(', '[', '{', '<']
  getter closers = [')', ']', '}', '>']

  def initialize(f : String)
    @input = File.read_lines(f).map(&.chars)
  end

  def corrupt(l)
    s = Deque(Char).new
    l.each do |c|
      if openers.includes?(c)
        s.unshift(closers[openers.index(c).not_nil!])
      else
        return c if c != s.shift?
      end
    end
    s.to_a
  end

  def part1
    score = {')' => 3, ']' => 57, '}' => 1197, '>' => 25137}
    input.compact_map { |l| x = corrupt(l); x.is_a?(Char) ? x : nil }.map { |c| score[c] }.sum
  end

  def part2
    scores = input.compact_map { |l| x = corrupt(l); x.is_a?(Array(Char)) ? x : nil }.map { |l| l.reduce(0_u64) { |acc, c| acc * 5 + closers.index(c).not_nil! + 1 } }.sort
    scores[(scores.size//2)]
  end
end

d = Day10.new("day10.txt")

pp d.part1
pp d.part2
