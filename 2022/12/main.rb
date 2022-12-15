def test
  puts "--- Test Data In Use ---".italic.yellow
"""Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""".split("\n")
end

class Node
  attr_accessor :x, :y, :height, :neighbors
  def initialize(x, y, height)
    @x = x
    @y = y
    @height = 0  if height == "S"
    @height = 25 if height == "E"
    @height = Array("a".."z").index(height) unless @height
    binding.pry if @height.nil?
    @neighbors = []
  end

  def add_neighbor(node)
    @neighbors << node
  end

  def distance_to(other)
    (@x - other.x).abs + (@y - other.y).abs
  end

  def distance_3d(other)
    Math.sqrt((@x - other.x).abs**2 + (@y - other.y).abs**2 + (height * 10 - other.height * 10).abs**2)
  end

  def distance_with_height(other)
    offset = (other.height - @height) > 1 ? 100 : 0
    distance_to(other) + ((other.height - height).abs * offset.to_i)
  end

  def closest_neighbor_to(other)
    @neighbors.min_by { |n| n.distance_with_height(other) }
  end

  def inspect
    "(#{@x},#{@y})[#{Array("a".."z")[height]}/#{@height}]"
  end

  def to_s(show_neighbors = false)
    "(#{@x},#{@y})[#{Array("a".."z")[height]}/#{@height}]" + (show_neighbors ? " -> #{neighbors.map(&:to_s)}" : '')
  end
end

class Graph
  attr_reader :start, :goal
  def initialize(nodes)
    @nodes = []

    nodes.each.with_index do |line, y|
      @nodes << line.split('').map.with_index do |n, x| 
        node = Node.new(x, y, n)
        @start = node if n == "S"
        @goal  = node if n == "E"
        node
      end
    end

    each do |node, x, y|
      [
        [y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]
      ].each do |n_y, n_x|
        if [(0...height - 1).cover?(n_y), (0..width - 1).cover?(n_x)].all?
          neighbor = self[y: n_y, x: n_x]
          if !node.neighbors.include?(neighbor) 
            node.add_neighbor(neighbor)
          end
        end
      end
    end
  end

  def set_start(node) = @start = node
  def set_goal(node)  = @goal  = node

  def height = @nodes.size
  def width  = @nodes.first.size

  def [](x:, y:) = @nodes[y][x]

  def each
    @nodes.each.with_index do |row, y|
      row.each.with_index do |node, x|
        yield(node, x, y)
      end
    end
  end

  def print_map(active_node = nil, visited = [])
    each do |node, x, y|
      print "\n" if x.zero?
      char = Array("a".."z")[node.height]
      case
      when node == @start then char = "S"
      when node == @goal  then char = "E"
      when node == active_node then char = char.bold.bg_yellow
      when visited.include?(node) then char = "#".bold.red
      end
       height = (node).distance_with_height(@goal).to_s.rjust(3, " ").ljust(4, " ")
      print char.shade((active_node || node).distance_with_height(node), max: 320)
    end
    puts
  end
end

def build_path(graph_start, graph_goal, came_from)
  return [] unless came_from.keys.include?(graph_goal)
  current = graph_goal
  path = []
  while current != graph_start
    path << current
    current = came_from[current]
  end
  path << graph_start
  path.reverse
end

def solve(graph, start, goal)
  unvisited = [{start => 0}]
  came_from = {start => nil}
  trip_cost = {start => 0}
  current   = nil

  until unvisited.empty? do
    node = unvisited.min_by(&:values)
    unvisited.delete(node)
    prev    = current unless current.nil?
    current = node.keys.first
    # clear
    # puts
    # puts "Path: #{build_path(graph.start, prev, came_from).map { |x| "#{Array("a".."z")[x.height]}"}.join(" -> ")}"
    # puts "Current: #{trip_cost[current]} #{current}"
    # graph.print_map(current, [])
    # warn node
    # current.neighbors.each do |n|
    #   puts "  #{n} #{trip_cost[current] + current.distance_with_height(n)}"
    # end
    # puts

    break if current == goal

    current.neighbors.each do |neighbor|
      cost = trip_cost[current] + current.distance_with_height(neighbor)
      if cost < trip_cost.fetch(neighbor, Float::INFINITY)
        trip_cost[neighbor] = cost
        priority = cost + neighbor.distance_to(goal)
        unvisited.push({neighbor => priority})
        came_from[neighbor] = current
      end
    end
  end
  return [came_from, trip_cost]
end

puzzle '12.1', mode: :count, answer: nil do |input, total|
  graph = Graph.new(input.map(&:chomp))
  graph.print_map

  node = graph.start
  dist = graph.start.distance_with_height(graph.goal)
  visited = [node]
  unvisited = graph.start.neighbors.dup

  came_from, trip_cost = solve(graph, graph.start, graph.goal)

  v = []
  build_path(graph.start, graph.goal, came_from).each do |node|
    # clear
    # puts node.to_s(true)
    # node.neighbors.each do |n|
    #   puts "\t#{n} -> R: #{node.distance_with_height(n)} | G: #{n.distance_with_height(graph.goal)} | 3D: #{n.distance_3d(graph.goal)}"
    # end
    # graph.print_map(node, v += [node])
    # gets
  end

  binding.pry
end

xpuzzle '12.2', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end
