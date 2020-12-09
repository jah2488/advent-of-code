require_relative "../helpers"
class SizedQueue
  def initialize(size)
    @size = size
    @coll = []
  end

  def add(item)
    if @coll.length < @size
      @coll.push(item)
    else
      @coll.shift
      @coll.push(item)
    end
  end

  def sums_for(num)
    @coll.combination(2).select { |(a, b)| a + b == num }
  end
end

def find_contiguous_sum(input, target)
  nums = []
  input.each do |x|
    break if nums.sum == target
    next if x > target

    nums << x

    next if nums.sum > target
    input.each do |y|
      break if nums.sum == target
      next if y > target

      nums << y

      if nums.sum > target
        nums = []
      end
    end
  end
  [nums.min, nums.max]
end

def exploit(input, preamble)
  opts = SizedQueue.new(preamble)

  input.map!(&:to_i)
  input.take(preamble).each { |n| opts.add(n) }

  input[preamble..-1].each.with_index do |n, i|
    matches = opts.sums_for(n)
    if matches.empty?
      min, max = find_contiguous_sum(input, n)
      if min && max
        puts n, min + max
        exit
      else
        fail
      end
    else
      opts.add(n)
    end
  end
end

puzzle "9" do |input|
  exploit(input, 25)
end
