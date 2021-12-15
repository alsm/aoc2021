struct Point
  property x, y

  def initialize(@x : Int32, @y : Int32)
  end
end

class PriorityQueue(T)
  def initialize
    @queue = Hash(Int32, Array(T)).new
    @map = Hash(T, Int32?).new(nil)
  end

  def push(obj : T, prio)
    current_prio = @map[obj]
    if current_prio != prio
      unless current_prio.nil?
        list = @queue[current_prio]
        list.delete(obj)
        @queue.delete(current_prio) if list.empty?
      end
      @queue[prio] = Array(T).new if !@queue[prio]?
      @queue[prio] << obj
      @map[obj] = prio
    end
  end

  def pop_min
    pop(@queue.keys.min)
  end

  def pop_max
    pop(@queue.keys.max)
  end

  def priorities
    @queue.keys
  end

  def pop(prio)
    list = @queue[prio]
    obj = list.shift
    @queue.delete(prio) if list.empty?
    @map.delete(obj)
    return obj
  end

  def size
    @queue.map { |_, l| l.size }.sum
  end

  def empty?
    @queue.empty?
  end
end
