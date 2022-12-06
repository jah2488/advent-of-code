def test
  warn "Test Data In Use"
  "mjqjpqmgbljsphdztnvjfqwrcgsmlb" #=> 7, 19
end

def test2
  warn "Test Data In Use"
  "bvwbjplbgvbhsrlpgdmjqwftvncz" #=> 5, 23
end

def test3
  warn "Test Data In Use"
  "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" #=> 10, 29
end

class Win
  def initialize(size = 4)
    @size = size
    @storage = []
  end

  def add(char)
    @storage.shift if @storage.size == @size
    @storage << char
    self
  end

  def uniq?
    return false if @storage.size < @size
    @storage.uniq.size == @storage.size
  end
end

def solve(input, size)
  win = Win.new(size)
  input.chars.each_with_index do |char, idx|
    if win.add(char).uniq?
      return idx + 1
    end
  end
end

puzzle '6.1', mode: :count, input: :raw, answer: 1794 do |input, first_char|
  solve(input, 4)
end

puzzle '6.2', mode: :count, input: :raw, answer: 2851 do |input, first_char|
  solve(input, 14)
end
