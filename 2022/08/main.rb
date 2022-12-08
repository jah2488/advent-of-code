def test
  puts "--- Test Data In Use ---".italic.yellow
"""30373
25512
65332
33549
35390
"""
end

def search(grid, loc, height, vector)
  y = loc[0] + vector[0]
  x = loc[1] + vector[1]
  return true if y < 0 || x < 0 || grid[y].nil? || grid[y][x].nil?
  grid[y][x] < height ? search(grid, [y, x], height, vector) : false
end

def tally(grid, loc, height, vector, visited = [])
  y = loc[0] + vector[0]
  x = loc[1] + vector[1]
  return visited if y < 0 || x < 0 || grid[y].nil? || grid[y][x].nil?
  visited.push(grid[y][x])
  grid[y][x] < height ? tally(grid, [y, x], height, vector, visited) : visited
end

def perimeter(grid) = grid.length * 2 + grid[0].length * 2 - 4

puzzle '8.1', mode: :count, input: :raw, answer: 1705 do |input, total|
  grid = test.split("\n").map { |x| x.split('') }
  total += perimeter(grid)
  puts "Total: #{perimeter(grid)}".bold
  x, y = 0, 0
  until y >= grid.length do
    x = 0
    until x >= grid[y].length do
      if x > 0 && x < grid[y].length - 1 && y > 0 && y < grid.length - 1
        if [
          search(grid, [y, x], grid[y][x], [-1,  0]),
          search(grid, [y, x], grid[y][x], [ 1,  0]),
          search(grid, [y, x], grid[y][x], [ 0, -1]),
          search(grid, [y, x], grid[y][x], [ 0,  1]),
        ].any?
          total += 1
          print "#{grid[y][x]}".green.bold
        else
          print "#{grid[y][x]}".yellow
        end
      else
        print "#{grid[y][x]}"
      end
      x += 1
    end
      print "\n"
    y += 1
  end
  total
end

puzzle '8.2', mode: :count, input: :raw, answer: 371200 do |input, top_score|
  grid = input.split("\n").map { |x| x.split('') }
  puts "Total: #{perimeter(grid)}".bold
  x, y = 0, 0
  until y >= grid.length do
    x = 0
    until x >= grid[y].length do
      if x > 0 && x < grid[y].length - 1 && y > 0 && y < grid.length - 1
        if [
          search(grid, [y, x], grid[y][x], [-1,  0]),
          search(grid, [y, x], grid[y][x], [ 1,  0]),
          search(grid, [y, x], grid[y][x], [ 0, -1]),
          search(grid, [y, x], grid[y][x], [ 0,  1]),
        ].any?
          scenic_score = [
           tally(grid, [y, x], grid[y][x], [-1,  0]),
           tally(grid, [y, x], grid[y][x], [ 1,  0]),
           tally(grid, [y, x], grid[y][x], [ 0, -1]),
           tally(grid, [y, x], grid[y][x], [ 0,  1]),
          ].map(&:size).reduce(&:*)
          if scenic_score > top_score
            top_score = scenic_score
          end
          print "#{scenic_score}".green.bold
        else
          print "#{grid[y][x]}".yellow
        end
      else
        print "#{grid[y][x]}"
      end
      x += 1
    end
      print "\n"
    y += 1
  end
  top_score
end
