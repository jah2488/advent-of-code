require_relative "../helpers"

class NF
  def self.convert(number)
    parts(number).join(",")
  end

  def self.parts(number)
    left, right = number.to_s.split(".")
    left.gsub!(delimiter_pattern) do |digit_to_delimit|
      "#{digit_to_delimit},"
    end
    [left, right].compact
  end

  def self.delimiter_pattern
    /(\d)(?=(\d\d\d)+(?!\d))/
  end
end

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

  def combination(n)
    @coll.combination(n)
  end

  def to_s
    @coll.to_s
  end

  def inspect
    @coll.inspect
  end
end

def sums_for(num, options)
  options.combination(2).select { |(a, b)|
    a + b == num
  }
end

def find_contiguous_sum(input, x)
  nums = []
  input.each do |n|
    return [nums.first, nums.last] if nums.sum == x
    if nums.sum > x
      puts
      puts
      jj = 0
      nums.reverse_each do |j|
        jj += j
        puts "Current:[%8s] acc(%8s) Target[%8s] diff(acc)(%8s) diff(target)(%8s) " % ([j, jj, x, x - jj, x - j].map { |z| NF.convert(z) })
      end
      break
    end
    nums << n
  end
  idx = 0
  sum = nums.sum
  puts
  puts
  puts
  while sum >= x
    sum = nums[idx..-1].sum
    idx += 1
    puts "Current:[%8s] acc(%8s) Target[%8s] diff(acc)(%8s) diff(target)(%8s) " % ([nums[idx], sum, x, x - sum, x - nums[idx]].map { |z| NF.convert(z) })
  end
  puts
  puts "|-------------------"
  puts "|target_: %s" % [x]
  puts "|num sum: %s (%s)" % [nums.sum == x ? nums.sum.to_s.green : nums.sum.to_s.red, x - nums.sum]
  puts "|sum num: %s (%s)" % [sum == x ? sum.to_s.green : sum.to_s.red, x - sum]
  puts "|" + [nums.first, nums.last]
  puts "|-------------------"
  [nums.first, nums.last]
end

def exploit(input, preamble, used, curr)
  input.map!(&:to_i)
  opts = SizedQueue.new(preamble)
  input.map(&:to_i).take(preamble).map { |n| opts.add(n) }

  input[preamble..-1].each.with_index do |n, i|
    curr = i
    matches = sums_for(n, opts)
    if matches.nil? || matches.empty?
      print "no matches found for '%s' %s" % [n, matches]
      min, max = find_contiguous_sum(input, n)
      if min && max
        exit
      else
        fail
      end
    else
      opts.add(n)
    end
  rescue => e
    print "ERR " + e.message
    puts "index (%s)" % [i + preamble]
    puts "%d => %s" % [n, opts]
    puts "\t #{matches.inspect}"
    exit
  end
end

puzzle "9" do |input|
  used = []
  current = 0
  preamble = 25
  exploit(input, preamble, used, current)
end

def partial(path)
  @erb_buffer.then do |buffer|
    buffer << render(path).ifThen(block_given?) { |result| yield result}
  end
  buffer << result
end