require_relative '../helpers.rb'

def test
  "16,1,2,0,4,2,7,1,2,14\n"
end

puzzle '7.1', input: :raw do |input|
  crabs = input.split(',').map(&:to_i)
  lowest = Float::INFINITY 
  1.upto(crabs.max).each do |dest|
    cost = crabs.map { |crab| crab > dest ? crab - dest : dest - crab }.sum
    if cost < lowest
      lowest = cost
    end
    #puts "Cost for #{dest} is #{cost}"
  end
  puts lowest
end

puzzle '7.2', input: :raw do |input|
  crabs = input.split(',').map(&:to_i)
  lowest = Float::INFINITY 
  1.upto(crabs.max).each do |dest|
    cost = crabs.map do |crab| 
      steps = crab > dest ? crab - dest : dest - crab 
      [].tap { |s| steps.times { |n| s << (n + 1) } }.sum
    end.sum
    if cost < lowest
      lowest = cost
    end
    #puts "Cost for #{dest} is #{cost}"
  end
  puts lowest
end