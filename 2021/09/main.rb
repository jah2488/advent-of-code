require_relative '../helpers'

def test
  [
    "2199943210\n",
    "3987894921\n",
    "9856789892\n",
    "8767896789\n",
    "9899965678\n",
  ]
end

def p_grid(grid, cur)
  north, south, east, west = nil
  out = "\n"
  out << "x: #{cur[0]} y: #{cur[1]}\n"
  0.upto(grid.length - 1) do |x|
    out << "\n"
    0.upto(grid.first.length - 1) do |y|
      target  = grid[cur[0]][cur[1]]
      current = grid[x][y]
      west = grid[x][y - 1]
      east = grid[x][y + 1]
      if x > 0
        north = grid[x - 1][y] 
      else
        north = "10"
      end
      if x < grid.length - 1
        south = grid[x + 1][y]
      else
        south = "10"
      end

      if [west, east, north, south, current].compact.map(&:to_i).min == current.to_i
        if cur[1] == 0 && cur[0] == 0 && current != 9
          $low_points << current.to_i + 1 if cur[1] == 0 && cur[0] == 0 && current.to_i != 9
        else
          #return
        end
      end
 

      if x == cur[0] && y == cur[1]
        out << target.bold.purple
        next
      end

      if x == cur[0] + 1 && y == cur[1]
        if target > current
          out << current.green
        else
          out << current.red
        end
        next
      end 

      if x == cur[0] && y == cur[1] + 1
        if target > current
          out << current.green
        else
          out << current.red
        end
        next
      end 

      if x == cur[0] - 1 && y == cur[1]
        if target > current
          out << current.green
        else
          out << current.red
        end
        next
      end 

      if x == cur[0] && y == cur[1] - 1
        if target > current
          out << current.green
        else
          out << current.red
        end
        next
      end 

      if [west, east, north, south, current].compact.map(&:to_i).min == current.to_i
        out << current.yellow
      else
        if current == "9"
          out << current.black.italic
        else
          out << current
        end
      end
    end
  end
  out << "\n"
  puts out
end

puzzle '9.1', mode: test do |input|
  $low_points = []
  grid = input.map { |line| line.chomp.chars }
  (0..grid.length - 1).each do |x|
    (0..grid.first.length - 1).each do |y|
      system('clear')
      p_grid(grid, [x, y])
      sleep 0.15
    end
  end
  puts
  puts "Sum: #{$low_points.sum}"
end