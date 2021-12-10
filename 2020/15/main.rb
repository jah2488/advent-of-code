require_relative "../helpers"

def spoken(set, goal)
  nums = {}
  turn = 1
  last = set.last
  set.cycle.each do |n|
    break if turn > goal
    puts "\t" + nums.inspect
    puts "\t[#{last}]->[#{n}]"
    str = "Turn #{turn}: "
    if turn > set.length
      if nums[last]
        str += (nums[last]).to_s
        nums[last] = turn
      else
        str += "0"
        nums[0] = turn
      end
    else
      nums[n] = 0
    end
    puts str
    turn += 1
    last = n
  end
end

puts spoken([0, 3, 6], 10)
