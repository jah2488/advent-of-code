require_relative "../helpers"

def find_nearest(goal, num)
  puts
  up = num
  down = num
  until (goal % up).zero?
    print num, ", ", up, ", ", goal.divmod(up), "\n"
    up += 1
  end
  until (goal % down).zero?
    print num, ", ", down, ", ", goal.divmod(down), "\n"
    down -= 1
  end
  r = [{dir: :up, n: up, o: num}, {dir: :down, n: down, o: num}]
  print "n: ", num, " up: #{up} (", (num - up).abs, ") down: #{down} (", (num - down).abs, ")\n"
  r.min { |x| x[:dir] == :up ? (x[:n] - num) : (num - x[:n]) }
end

# 939
# 7,13,x,x,59,x,31,19
puzzle "13" do |input|
  puts
  times = 939 # input.first.to_i
  buses = %w[7 13 59 31 19].map(&:to_i) # input.last.split(",").reject { |x| x == "x" }.map(&:to_i)
  sort = buses.map { |x| find_nearest(times, x) }
  puts times, buses.inspect, sort.inspect
  d = sort.min { |x| times + x[:n] }
  puts d, (times + d[:n]) * d[:o]
end
