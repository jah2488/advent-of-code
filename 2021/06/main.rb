require_relative '../helpers.rb'

def test
  ["3,4,3,1,2"]
end

puzzle '6.1', mode: test do |input|
  fish = input.flat_map { |line| line.split(',').map(&:to_i) }
  days = []
  puts "Initial State: #{fish.join(",")}"
  18.times do |n|
    days << fish 
    new_fish = 0

    fish = fish.map do |f|
      case f
      when 0
        new_fish += 1
        6
      else
        f - 1
      end
    end
    new_fish.times { fish << 8 }

    if fish.count < 10
      puts "After #{n} Days: #{fish.join(",")}"
    else
      puts "After #{n} Days: #{fish.count}"
    end
  end
end

puzzle '6.2' do |input|
  school = { 8 => 0, 7 => 0, 6 => 0, 5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0, 0 => 0 }
  input.flat_map { |line| line.split(',').map(&:to_i) }.each { |f| school[f] += 1 }
  256.times do |n|
    puts "After #{n + 1} Days: #{school.values.sum + school[0]}" if n > 0
    school = { 
      8 => school[0], 
      7 => school[8], 
      6 => school[7] + school[0], 
      5 => school[6],
      4 => school[5], 
      3 => school[4], 
      2 => school[3], 
      1 => school[2], 
      0 => school[1] 
    }
  end
end