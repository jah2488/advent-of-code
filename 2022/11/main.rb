def test
  puts "--- Test Data In Use ---".italic.yellow
"""
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
    """
end

class Monkey
  OP_RE = /new = old (\+|\*) (\d+|old)/
  attr_accessor :items, :num, :inspection_count

  def initialize(barrel, num, items, operation, pred, if_true, if_false, worry_reduction = false)
    @barrel = barrel
    @num = num
    @items = items.split(', ').map(&:to_i)
    @operation = operation
    @pred = pred.gsub('divisible by ', '').to_i
    @if_true = if_true.to_i
    @if_false = if_false.to_i
    @inspection_count = 0
    @worry_reduction = worry_reduction
  end

  def toss(item, to)
    @active_item = nil
    @barrel[to].catch_item(item)
  end

  def catch_item(item)
    @items << item
  end

  def inspect_item
    @active_item = @items.shift
    return if @active_item.nil?
    @active_item = perform_operation
    @active_item = (@active_item.to_f / 3.0).floor if @worry_reduction
    @inspection_count += 1
  end

  def perform_operation
    match = OP_RE.match(@operation)
    operator = match[1]
    amount   = match[2] == 'old' ? @active_item : match[2].to_i
    return @active_item + amount if operator == '+'
    return @active_item * amount if operator == '*'
  end

  def test_item
    return if @active_item.nil?
    if @active_item % @pred == 0
      toss(@active_item, @if_true)
    else
      toss(@active_item, @if_false)
    end
  end
end

puzzle '11.1', mode: :count, input: :raw, answer: 120056 do |input, total|
  barrel = []
  monkey_re = /Monkey (\d):\n  Starting items:(.*)\n  Operation: (.+)\n  Test: (.+)\n    If true: throw to monkey (.+)\n    If false: throw to monkey (.+)/
  input.scan(monkey_re).each do |monkey_attrs|
    barrel << Monkey.new(barrel, *monkey_attrs, true)
  end

  20.times do |round|
    barrel.each do |monkey|
      monkey.items.count.times do
        monkey.inspect_item
        monkey.test_item
      end
    end

  end
  barrel.each do |monkey|
    puts "Monkey #{monkey.num} inspected #{monkey.inspection_count} items".bold
  end
  barrel.map(&:inspection_count).sort[-2..-1].reduce(:*)
end

xpuzzle '11.2', mode: :count, input: :raw, answer: nil do |input, total|
  barrel = []
  monkey_re = /Monkey (\d):\n  Starting items:(.*)\n  Operation: (.+)\n  Test: (.+)\n    If true: throw to monkey (.+)\n    If false: throw to monkey (.+)/
  test.scan(monkey_re).each do |monkey_attrs|
    barrel << Monkey.new(barrel, *monkey_attrs, false)
  end

  10_000.times do |round|
    barrel.each do |monkey|
      monkey.items.count.times do
        monkey.inspect_item
        monkey.test_item
      end
    end
  end
  barrel.each do |monkey|
    puts "Monkey #{monkey.num} inspected #{monkey.inspection_count} items".bold
  end
  barrel.map(&:inspection_count).sort[-2..-1].reduce(:*)
end
