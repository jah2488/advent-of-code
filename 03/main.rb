require_relative "../helpers"

puzzle "3.1", mode: :count do |input, count|
  rotation = input.first.length + 1
  left = 3
  pos = 0
  input.each.with_index do |line, idx|
    line = line.chomp
    space = line[pos]
    if idx.even?
      pos = (pos + left) % rotation
    elsif space == "#"
      count += 1
    end
    line[pos] = line[pos] == "#" ? "∆" : "@" if idx.odd?
    puts "[#{"%4d" % count}][#{idx.even? ? "e" : "o"}][#{"%4d" % idx}][#{"%4d" % pos}] | " + line + " | #{space}"
  end
  puts count
end
