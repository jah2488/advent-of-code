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
    return idx + 1 if win.add(char).uniq?
  end
end

def fast_solve(input, size)
  n = 0
  chars = {}
  while n < input.length
    char = input[n]
    chars[char] = chars[char].to_i + 1

    return n if chars.length == size && chars.values.sum == size

    if chars.values.sum > size || chars[char] > 1
      chars = { char => 1}
    end

    n += 1
  end
end


puzzle '6.1', mode: :count, input: :raw, answer: 1794 do |input, first_char|
  #solve(input, 4)
  fast_solve(input, 4) + 1 # Why is this needed, the biggest mystery yet to be solved 🧐
end

puzzle '6.2', mode: :count, input: :raw, answer: 2851 do |input, first_char|
  #solve(input, 14)
  fast_solve(input, 14)
end
