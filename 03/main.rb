require_relative "../helpers"

def count_slope(input, left, down)
  rotation = input.first.length - 1
  count = 0
  pos = {x: 0, y: 0}
  input.length.times do |n|
    break if input[pos[:y]].nil?

    terrain = input[pos[:y]][pos[:x]]
    count += 1 if terrain == "#"

    input[pos[:y]][pos[:x]] = "\033[31m#{input[pos[:y]][pos[:x]]}\033[0m"
    puts "[#{"%4d" % count}][#{"%4d" % n}][#{"%4d" % pos[:x]},#{"%4d" % pos[:y]}] | " + input[pos[:y]].chomp + " | #{"\033[31m#{terrain}\033[0m" if terrain == "#"}"

    pos[:x] = (pos[:x] + left) % rotation
    pos[:y] = (pos[:y] + down)
  end
  count
end

puzzle "3.1", mode: :count, answer: 191 do |input, count|
  count_slope(input, 3, 1)
end

puzzle "3.2" do |input|
  slopes = [
    [1, 1], [3, 1], [5, 1], [7, 1], [1, 2]
  ]

  dup = ->(m) { m.map(&:dup).dup }

  slopes
    .map { |(left, down)| count_slope(dup.call(input), left, down) }
    .tap { |x| puts x }
    .reduce(:*)
    .tap { |n| puts n }
end
