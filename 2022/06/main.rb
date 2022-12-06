def test
  puts "--- Test Data In Use ---".italic.yellow
  "mjqjpqmgbljsphdztnvjfqwrcgsmlb" #=> 7, 19
end

def test2
  puts "--- Test Data In Use ---".italic.yellow
  "bvwbjplbgvbhsrlpgdmjqwftvncz" #=> 5, 23
end

def test3
  puts "--- Test Data In Use ---".italic.yellow
  "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" #=> 10, 29
end

class Win
  def initialize(size = 4)
    @size = size
    @storage = []
  end

  def add(char)
    # puts "Duplicate detected".red.italic if @storage.include?(char)
    if @storage.size == @size
      @storage.shift
    end
    @storage << char
  end

  def uniq?
    return false if @storage.size < @size
    @storage.uniq.size == @storage.size
  end

  def to_s
    @storage.inspect
  end
end

puzzle '6.1', mode: :count, input: :raw, answer: 1794 do |input, total|
  win = Win.new
  first_char = 0
  input.chars.each_with_index do |char, idx|
    win.add(char)
    if win.uniq?
     # puts "Win: #{win}, at: #{idx + 1}" 
      first_char = idx + 1
      break
    end
  end
  first_char
end

puzzle '6.2', mode: :count, input: :raw, answer: 2851 do |input, total|
  win = Win.new(14)
  first_char = 0
  input.chars.each_with_index do |char, idx|
    win.add(char)
    if win.uniq?
     # puts "Win: #{win}, at: #{idx + 1}" 
      first_char = idx + 1
      break
    end
  end
  first_char
end
