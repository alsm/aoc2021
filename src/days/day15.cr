require "./helpers.cr"

class Day15
  property cost = Hash(Point, Int32).new

  def initialize(f : String)
    File.read_lines(f).map(&.chars.map(&.to_i32)).each_with_index do |l, i|
      l.each_with_index { |v, j| @cost[Point.new(j, i)] = v }
    end
  end

  def neighbours(p : Point)
    [[0, 1], [0, -1], [1, 0], [-1, 0]].map { |(dx, dy)| np = Point.new(dx + p.x, dy + p.y); cost.has_key?(np) ? np : nil }.compact
  end

  def route(start, goal)
    frontier = PriorityQueue(Point).new
    frontier.push(start, 0)
    came_from = Hash(Point, Point?).new
    cost_so_far = Hash(Point, Int32).new
    came_from[start] = nil
    cost_so_far[start] = 0

    while !frontier.empty?
      current = frontier.pop_min
      break if current == goal
      neighbours(current).each do |p|
        if !cost_so_far.has_key?(p)
          cost_so_far[p] = new_cost
          priority = new_cost
          frontier.push(p, new_cost)
          came_from[p] = current
        end
      end
    end

    route = [] of Point
    n = came_from[goal]
    while n != start
      route << n.not_nil!
      n = came_from[n]
    end
    route.unshift(goal)
    route.reverse.map { |p| cost[p] }.sum
  end

  def part1
    route(Point.new(0, 0), Point.new(99, 99))
  end

  def part2
    l = cost.max_of { |p, v| p.x } + 1
    cost.each { |p, v| (0..4).to_a.repeated_combinations.map { |(x, y)| cost[Point.new(x*100 + p.x, y*100 + p.y)] = ((v + x + y - 1) % 9) + 1 } }
    route(Point.new(0, 0), Point.new(499, 499))
  end
end

d = Day15.new("day15.txt")
pp d.part1
pp d.part2
