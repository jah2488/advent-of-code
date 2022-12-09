require 'set'
def test
  puts "--- Test Data In Use ---".italic.yellow
  [
    "R 4",
    "U 4",
    "L 3",
    "D 1",
    "R 4",
    "D 1",
    "L 5",
    "R 2",
  ] # 13, 1
end

def test2
  [
    "R 5",
    "U 8",
    "L 8",
    "D 3",
    "R 17",
    "D 10",
    "L 25",
    "U 20",
  ] # ?, 36
end

class Point
  attr_accessor :x, :y

  def self.zero = new(0, 0)

  def initialize(x, y) = (@x = x; @y = y)

  def touching?(other)
    [other.x - 1, other.x, other.x + 1].include?(x) && 
    [other.y - 1, other.y, other.y + 1].include?(y)
  end

  def above?(other) = y > other.y
  def below?(other) = y < other.y
  def left?(other)  = x < other.x
  def right?(other) = x > other.x

  def ==(other)   = x == other.x && y == other.y
end

def simulate(input, rope)
  head = rope.first
  tail = rope.last
  points = []
  input.each do |move|
    direction, distance = move.split(' ')
    distance.to_i.times do
      case direction
      when 'U' then head.x -= 1
      when 'D' then head.x += 1
      when 'L' then head.y -= 1
      when 'R' then head.y += 1
      end

      rope.each_cons(2) do |front, back|
        unless back.touching?(front)
          back.y += 1 if front.above?(back)
          back.y -= 1 if front.below?(back)
          back.x -= 1 if front.left?(back)
          back.x += 1 if front.right?(back)
        end
      end

      points << Point.new(tail.x, tail.y) unless points.include?(tail)
    end
  end
  points.count
end

puzzle '9.1', mode: :count, answer: 5710 do |input, total|
  simulate(input, [Point.zero, Point.zero])
end

puzzle '9.2', mode: :count, answer: 2259 do |input, total|
  simulate(input, Array.new(10) { Point.zero })
end

def visualize
  # clear
  # out = "MOVE: #{move}\n\n"
  # 50.times do |x|
  #   50.times do |y|
  #     if rope.any? { |p| p.x + 25 == x && p.y + 25 == y }
  #       rope_index = rope.index { |p| p.x + 25 == x && p.y + 25 == y }
  #       if rope_index.zero?
  #         out << "H".bold
  #       else
  #         out << rope_index.to_s
  #       end
  #     elsif x == 25 && y == 25
  #       out << "s".bold
  #     elsif points.any? { |p| p.x + 25 == x && p.y + 25 == y }
  #       out << "*"
  #     else
  #       out << "."
  #     end
  #   end
  #   out << "\n"
  # end
  # puts out
end
