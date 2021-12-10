require_relative '../helpers'

def test
  [
    "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010",
  ]
end

puzzle '3.1' do |input|
  gamma = ''
  epsilon = ''
  input.map { |row| row.chomp.split('').map(&:to_i)}.transpose.each do |n|
    ones  = n.count(1)
    zeros = n.count(0)
    if ones > zeros
      gamma += '1'
      epsilon += '0'
    else
      gamma += '0'
      epsilon += '1'
    end
  end
  puts gamma.to_i(2) * epsilon.to_i(2)
end


def bit_crit(input, indicies, offset)
  return if $found
  return if indicies.empty?
  if indicies.length <= 1
    puts input[indicies.first], input[indicies.first].to_i(2)
    $found = true
    return
  end
  indicies.map { |idx| input[idx].chomp.split('').map(&:to_i) }.transpose.each.with_index do |n, idx|
    next if idx < offset
    ones  = n.count(1)
    zeros = n.count(0)
    indicies = n.map.with_index { |x, idx| x == (ones >= zeros ? 1 : 0) ? indicies[idx] : nil }.compact
    bit_crit(input, indicies, offset + 1)
  end
end

puzzle '3.2' do |input|
  input.map { |row| row.chomp.split('').map(&:to_i) }.transpose.each do |col|
    return if $found
    ones  = col.count(1)
    zeros = col.count(0)
    indicies = col.map.with_index { |x, idx| x == (ones >= zeros ? 1 : 0) ? idx : nil }.compact
    bit_crit(input, indicies, 1).inspect
  end
end