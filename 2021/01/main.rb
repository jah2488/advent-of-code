def test
  [
    199, 200, 208, 210, 200, 207, 240, 269, 260, 263
  ]
end

puzzle '1.1', mode: :count do |input, count|
  last = nil
  input.map(&:to_i).each do |n|
    if last.nil?
      puts "(N/A - no previous measurement)" 
      last = n
      next
    end

    if n > last.to_i
      count += 1
      puts "(increased)".green
    else
      puts "(decreased)".red
    end
    last = n
  end
  puts "Total: #{count}"
end

puzzle '1.2', mode: :count do |input, count|
  last_group = 0
  input.map(&:to_i).each.with_index do |n, idx|
    group = [n, input[idx + 1], input[idx + 2]].map(&:to_i)
    next if idx >= input.length - 2 || idx == 0
    print group.join(', ') + ' '
    group = group.map(&:to_i).sum

    print "#{Array('A'..'Z')[idx % 26]}: #{group} "
    if group > last_group
      count += 1
      puts "(increased)".green
    else
      puts "(decreased)".red
    end
    last_group = group
  end
  puts "Total: #{count}"
end