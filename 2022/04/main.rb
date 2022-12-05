def test
  puts "--- Test Data In Use ---".italic.yellow
  [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8"
  ]
end

def get_ranges(line)
  a, b = line.split(',')
  a_min, a_max = a.split('-').map(&:to_i)
  b_min, b_max = b.split('-').map(&:to_i)
  [(a_min..a_max), (b_min..b_max)]
end

def multiline_visualization(a, b)
  overlap = (a.to_a & b.to_a)
  range   = (a.to_a | b.to_a)
  output  = ""
  [[a, :yellow], [overlap, :green], [b, :blue]].each do |(range, color)|
    100.times do |n|
      if range.include?(n)
        if range.min == n || range.max == n
          output << "(#{n})".send(color).bold
        else
          output << "#{smooth_floor.to_s.rjust(1, " ")}".send(color).bold
        end
      else
        output << smooth_floor.black
      end
    end
    output << "\n"
  end
  puts
  puts output
end

def visualize(a, b, total)
  overlap = (a.to_a & b.to_a)
  range   = (a.to_a | b.to_a)
  output  = ""
  if (a.cover?(b) || b.cover?(a))
    #output << " [#{total.to_s.rjust(3, " ")}]".red.bold.italic 
    output << " [!]".red.bold.italic
  else
    output << " [#{"".to_s.rjust(1, " ")}]".bold.italic
  end
  output << " (#{"#{a.min.to_s.rjust(2, "0")}-#{a.max.to_s.rjust(2, "0")}".yellow}, #{"#{b.min.to_s.rjust(2, "0")}-#{b.max.to_s.rjust(2, "0")}".blue})"
  100.times do |n|
    case
    when overlap.include?(n) 
      if [a.min, b.min, a.max, b.max].include?(n)
        output << "⎨".green.bold if [a.max, b.max].include?(n)
        output << "#{n.to_s.rjust(1, " ")}".green.bold
        output << "⎬".green.bold if [a.min, b.min].include?(n)
      else
        output << smooth_floor.green.bold
      end
    when a.min == n          then output << "#{n.to_s.rjust(1, " ")}⎬".yellow
    when a.max == n          then output << "⎨#{n.to_s.rjust(1, " ")}".yellow
    when a.include?(n)       then output << smooth_floor.to_s.yellow
    when b.min == n          then output << "#{n.to_s.rjust(1, " ")}⎬".blue
    when b.max == n          then output << "⎨#{n.to_s.rjust(1, " ")}".blue
    when b.include?(n)       then output << smooth_floor.to_s.blue
    else
      output << smooth_floor.black
    end
  end
  output = rpad(output, 135, " ")
  output << "#{output.length} chars | #{strip_ansi(output).length} chars"
  puts output.rjust(140, "/")
end

# method that removes all ascii escape sequences from a string
def strip_ansi(string)
  string.gsub(/\e\[\d+m/, "")
end

# method that left-pads a string, ignoring ascii escape sequences
# usage: lpad("hello", 10, " ") #=> "     hello"
# usage: lpad("\033[43;1mhello\033[0m", 10, " ") #=> "     \033[43;1mhello\033[0m"
def lpad(string, length, char = " ")
  string_length = strip_ansi(string).length
  (length - string_length).times { string = char + string }
  string
end

# method that right-pads a string, ignoring ascii escape sequences
# usage: rpad("hello", 10, " ") #=> "hello     "
# usage: rpad("\033[43;1mhello\033[0m", 10, " ") #=> "\033[43;1mhello\033[0m     "
def rpad(string, length, char = " ")
  string_length = strip_ansi(string).length
  (length - string_length).times { string = string + char }
  string
end

puzzle '4.1', mode: :count, answer: 477 do |input, total|
  puts
  input.each do |line|
    a_range , b_range = *get_ranges(line)
    total += 1 if (a_range.cover?(b_range) | b_range.cover?(a_range))
    multiline_visualization(a_range, b_range)
  end
  total
end

puzzle '4.2', mode: :count, answer: 830 do |input, total|
  input.each do |line|
    a_range , b_range = *get_ranges(line)
    total += 1 if (
      a_range.include?(b_range.min) || a_range.include?(b_range.max) ||
      b_range.include?(a_range.min) || b_range.include?(a_range.max)
    )
  end
  total
end
