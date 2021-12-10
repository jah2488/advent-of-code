require_relative "../helpers"
#
# With these adapters, your device's built-in joltage adapter would be rated for 19 + 3 = 22 jolts, 3 higher than the highest-rated adapter.
#
# Because adapters can only connect to a source 1-3 jolts lower than its rating, in order to use every adapter, you'd need to choose them like this:
#
# The charging outlet has an effective rating of 0 jolts, so the only adapters that could connect to it directly would need to have a joltage rating of 1, 2, or 3 jolts.
# Of these, only one you have is an adapter rated 1 jolt (difference of 1).
# From your 1-jolt rated adapter, the only choice is your 4-jolt rated adapter (difference of 3).
# From the 4-jolt rated adapter, the adapters rated 5, 6, or 7 are valid choices. However, in order to not skip any adapters, you have to pick the adapter rated 5 jolts (difference of 1).
# Similarly, the next choices would need to be the adapter rated 6 and then the adapter rated 7 (with difference of 1 and 1).
# The only adapter that works with the 7-jolt rated adapter is the one rated 10 jolts (difference of 3).
# From 10, the choices are 11 or 12; choose 11 (difference of 1) and then 12 (difference of 1).
# After 12, only valid adapter has a rating of 15 (difference of 3), then 16 (difference of 1), then 19 (difference of 3).
# Finally, your device's built-in adapter is always 3 higher than the highest adapter, so its rating is 22 jolts (always a difference of 3).
# In this example, when using every adapter, there are 7 differences of 1 jolt and 5 differences of 3 jolts.
def input_a
  [
    "16\n",
    "10\n",
    "15\n",
    "5\n",
    "1\n",
    "11\n",
    "7\n",
    "19\n",
    "6\n",
    "12\n",
    "4\n"
  ]
end

# In this larger example, in a chain that uses all of the adapters, there are 22 differences of 1 jolt and 10 differences of 3 jolts.
def input_b
  [
    "28\n",
    "33\n",
    "18\n",
    "42\n",
    "31\n",
    "14\n",
    "46\n",
    "20\n",
    "48\n",
    "47\n",
    "24\n",
    "23\n",
    "49\n",
    "45\n",
    "19\n",
    "38\n",
    "39\n",
    "11\n",
    "1\n",
    "32\n",
    "25\n",
    "35\n",
    "8\n",
    "17\n",
    "7\n",
    "9\n",
    "4\n",
    "2\n",
    "34\n",
    "10\n",
    "3\n"
  ]
end

# Find a chain that uses all of your adapters to connect the charging outlet to your
# device's built-in adapter and count the joltage differences between the charging outlet,
# the adapters, and your device.
# What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?
def next_adapter(adapters, jolt)
  adapters.select { |a| (a - jolt) == 1 || ((a - jolt) <= 3 && (a - jolt) > 1) }
end

def chain_adapters(adapters, jolt, cons)
  next_adapter(adapters, jolt)
    .tap { |a| return cons + ["x"] if a.empty? }
    .flat_map { |n| chain_adapters(adapters, n, cons.dup + [n]) }
end

def walk_adapters(adapters, jolts, combinations)
  return combinations if adapters.length < 2 || jolts > adapters.max

  options = adapters.select { |adapter| [3, 2, 1].include?(adapter - jolts) }
  puts options.inspect
  puts "----"

  nj = jolts.succ
  unless nj >= adapters.max
    until adapters.include?(nj)
      nj = nj.succ
    end
  end

  combinations[jolts] = options
  walk_adapters(adapters, nj, combinations)
end

$count = 0
def count_paths(paths, start)
  print "." if $count % 10_000 == 0
  routes = paths.fetch(start, [])
  if routes.empty?
    $count += 1
  end
  routes.each do |n|
    count_paths(paths, n)
  end
end

# [1, 4, [5, 6, [7]], 10, [11, 12], 15, 16, 19]
# paths.keys.each do |jolt|
#  routes = paths[jolt]
#  if routes.empty?
#    $count += 1
#    next
#  end
# end

puzzle "10" do |input|
  one_jolt = 0
  three_jolt = 1
  base_adapters = input_b.map(&:to_i)

  adapters = [base_adapters, base_adapters.max + 3].flatten

  paths = walk_adapters(base_adapters, 0, {}).compact
  # paths = chain_adapters(input.map(&:to_i), 0, [])
  #   .reduce([0]) { |acc, n|
  #   prev = prev.nil? ? 0 : n
  #   p acc, prev, n
  #   acc + Array(n).map { |a|
  #     # puts "----"
  #     # p prev
  #     # puts
  #     # p a
  #     # puts "----"
  #     one_jolt += 1 if a - prev == 1
  #     three_jolt += 1 if a - prev == 3
  #     # puts "%4d -> %4d  (%d)" % [prev.last, a, a - prev.last]
  #     a
  #   }
  # })
  puts paths.length
  # puts paths.inspect
  # puts paths.map(&:length).inspect
  puts
  # puts one_jolt, three_jolt, one_jolt * three_jolt
  container = [nil, nil, nil, 1]
  base_adapters.sort.each do |adapter|
    container[adapter + 3] = container[adapter..(adapter + 2)].compact.sum
    puts "| %3d | %s" % [adapter, container.inspect.gsub("nil", "_")]
  end
  puts "Part 2: #{container.last}"

  binding.pry
end

class Array
  def smart_flatten(max = 100)
    c = 0
    r = self
    # r.map!
    until r.any? { |x| x.all? { |x| !x.is_a?(Array) } } || c > max
      r = r.flatten(1)
      c += 1
    end
    r
  end
end

#
# 1 4 5 10 11 151 16 19 22
# 1 4 6 10 11 15 16 18 22
#
#
