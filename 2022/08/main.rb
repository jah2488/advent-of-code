def test
  puts "--- Test Data In Use ---".italic.yellow
"""30373
25512
65332
33549
35390
""".split("\n")
end

def search(grid, loc, height, vector)
  y = loc[0] + vector[0]
  x = loc[1] + vector[1]
  return true if y < 0 || x < 0 || grid[y].nil? || grid[y][x].nil?
  grid[y][x] < height ? search(grid, [y, x], height, vector) : false
end

def perimeter(grid)
  grid.length * 2 + grid[0].length * 2 - 4
end

puzzle '8.0', mode: :count, input: :raw, answer: nil do |input, total|
  grid = input.split("\n").map { |x| x.split('') }
  total += perimeter(grid)
  puts "Total: #{perimeter(grid)}".bold
  binding.pry
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

xpuzzle '8.1', mode: :count, answer: nil do |input, total|
  visible_trees = { }

  puts "L -> R"
  # L -> R
  test.each.with_index do |line, idx|
    puts line.inspect
    next if idx == 0 || idx == test.size
    line.chars.each.with_index.reduce([]) do |trees, (char, index)|
      next trees if index == 0 || index == line.size
      if trees.size > 0 && trees.all? { |tree| tree < char.to_i }
        puts "TREE #{char} at #{[idx, index]} is seen, it is taller than #{trees.inspect}" 
        if visible_trees[[idx, index]]
          visible_trees[[idx, index]][char] << :left
        else
          visible_trees[[idx, index]] = { char => [:left] }
        end
      else
        puts "TREE #{char} is too short to see over #{trees.inspect}" 
      end
      trees << char.to_i
    end
  end


  puts "T -> B"

  # T -> B
  test.map { |x| x.split('') }.reduce(&:zip).map(&:flatten).each.with_index do |line, idx|
    next if idx == 0 || idx == test.size - 1
    line.each.with_index.reduce([]) do |trees, (char, index)|
      if trees.size > 0 && trees.all? { |tree| tree < char.to_i }
        puts "TREE #{char} at #{[index, idx]} is seen, it is taller than #{trees.inspect}" 
        if visible_trees[[index, idx]]
          visible_trees[[index, idx]][char] << :top
        else
          visible_trees[[index, idx]] = { char => [:top] }
        end
      else
        puts "TREE #{char} is too short to see over #{trees.inspect}" 
      end
      trees << char.to_i
    end
  end

  puts "R -> L"

  # R -> L
  rtl_trees = test.map(&:reverse)
  rtl_trees.each.with_index do |line, idx|
    next if idx == 0 || idx == rtl_trees.size
    line.chars.each.with_index.reduce([]) do |trees, (char, index)|
      if trees.size > 0 && trees.all? { |tree| tree < char.to_i }
        key = [rtl_trees.size - idx - 1, line.chars.size - index - 1]
        puts "TREE #{char} at #{key} is seen, it is taller than #{trees.inspect}" 
        if visible_trees[key]
          visible_trees[key][char] << :right
        else
          visible_trees[key] = { char => [:right] }
        end
      else
        puts "TREE #{char} is too short to see over #{trees.inspect}" 
      end
      trees << char.to_i
    end
  end

  puts "B -> T"

  # B -> T
  btt_trees = test.map { |x| x.split('').reverse }.reduce(&:zip).map(&:flatten)
  btt_trees.each.with_index do |line, idx|
    next if idx == 0 || idx == btt_trees.size
    line.each.with_index.reduce([]) do |trees, (char, index)|
      if trees.size > 0 && trees.all? { |tree| tree < char.to_i }
        key = [btt_trees.size - idx - 1, line.size - index - 1].reverse
        puts "TREE #{char} at #{key} is seen, it is taller than #{trees.inspect}" 
        if visible_trees[key]
          visible_trees[key][char] << :bottom
        else
          visible_trees[key] = { char => [:bottom] }
        end
      else
        puts "TREE #{char} is too short to see over #{trees.inspect}" 
      end
      trees << char.to_i
    end
  end

  visible_trees.each do |key, value|
    puts "TREE #{key} is visible from #{value.inspect}"
  end
  # 5, 5, 5, 3, 5
  "TOTAL: #{visible_trees.size}"
end


xpuzzle '8.2', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end
