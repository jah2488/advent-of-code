require_relative '../helpers.rb'

def test
  [
    'forward 5',
    'down 5',
    'forward 8',
    'up 3',
    'down 8',
    'forward 2',
  ]
end


puzzle '2.1' do |input|
  pos   = 0
  depth = 0
  input.each do |line|
    cmd, n = line.split(' ')
    case cmd
    when 'forward'
      pos += n.to_i
    when 'up'
      depth -= n.to_i
    when 'down'
      depth += n.to_i
    end
  end
  puts "Final position: #{pos} x #{depth} = #{pos * depth}"
end


puzzle '2.2' do |input|
  aim   = 0
  pos   = 0
  depth = 0
  input.each do |line|
    cmd, n = line.split(' ')
    case cmd
    when 'forward'
      pos += n.to_i
      depth += n.to_i * aim
    when 'up'
      aim -= n.to_i
    when 'down'
      aim += n.to_i
    end
  end
  puts "Final position: #{pos} x #{depth} = #{pos * depth}"
end