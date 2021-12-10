require_relative '../helpers.rb'

def lerp(a, b, t)
  a + (b - a) * t
end

def distance(a, b)
 # calculate the distance between two arrays of coordinates 
  Math.sqrt((a[0] - b[0])**2 + (a[1] - b[1])**2)
end

def test
  [
  "0,9 -> 5,9\n",
  "8,0 -> 0,8\n",
  "9,4 -> 3,4\n",
  "2,2 -> 2,1\n",
  "7,0 -> 7,4\n",
  "6,4 -> 2,0\n",
  "0,9 -> 2,9\n",
  "3,4 -> 1,4\n",
  "0,0 -> 8,8\n",
  "5,5 -> 8,2\n",
  ]
end

class Line
  def initialize(a, b)
    @a = a
    @b = b
  end

  def segments
    dx = @b[0] <=> @a[0]
    dy = @b[1] <=> @a[1]

    x = @a[0]
    y = @a[1]
    
    segs = []
    until x == @b[0] && y == @b[1] do
      segs << [x, y]

      x += dx
      y += dy
    end
    segs << [@b[0], @b[1]]
    segs
  end

  def points
    ((distance(@a, @b).round).times.map do |i| 
      [
        (lerp(@a[0], @b[0], i.to_f / distance(@a, @b))).to_i, 
        (lerp(@a[1], @b[1], i.to_f / distance(@a, @b))).to_i
      ] 
    end+ [@b])
  end

  def diagnal?
    (@a[0] != @b[0] && @a[1] != @b[1])
  end

  def to_s
    """
    #{@a[0]},#{@a[1]} -> #{@b[0]},#{@b[1]}
    """
  end
end

puzzle '5.1', answer: 8111 do |input|
  points = {}
  input.each do |line|
    p1, p2 = *line.split(' -> ').map { |p| p.split(',').map(&:to_i) }

    line = Line.new(p1, p2)

    Line.new(p1, p2).segments.each do |p|
      points[p] = (points[p] || 0) + 1
    end
  end
  puts
  puts points.select { |_, v| v > 1 }.keys.length
end