require_relative "../helpers"

puzzle "3.1", mode: :count, answer: 191 do |input, count|
  rotation = input.first.length - 1
  left = 3
  down = 1
  pos = {x: 0, y: 0}
  input.length.times do |n|
    pos[:x] = (pos[:x] + left) % rotation
    pos[:y] = (pos[:y] + down) % input.length
    terrain = input[pos[:y]][pos[:x]]
    count += 1 if terrain == "#"
    puts "[#{"%4d" % count}][#{"%4d" % n}][#{"%4d" % pos[:x]},#{"%4d" % pos[:y]}] | " + input[pos[:y]].chomp + " | #{terrain}"
  end
  puts count
end
