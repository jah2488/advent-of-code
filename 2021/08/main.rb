def test
  [
    "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
    "edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
    "fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
    "fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
    "aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
    "fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
    "dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
    "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
    "egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
    "gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce",
  ]
end

#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....

#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

DIGITS = {
  1 => %w(    c     f  ), # 2

  7 => %w(a   c     f  ), # 3

  4 => %w(  b c d   f  ), # 4

  5 => %w(a b   d   f g), # 5
  9 => %w(a b c     f g),
  2 => %w(a   c d e   g),
  3 => %w(a   c d   f g),

  0 => %w(a b c   e f g), # 6
  6 => %w(a b   d e f g),

  8 => %w(a b c d e f g), # 7

}

def digitz
  ["█", "▓", "▒", "░", "█"].sample
end

def display(wires, digit)
  space = "."
  is = -> (char) { -> (s) { s.chars.include? char } }

  Hash[DIGITS.map { |(k, v)| [v, k] }][wires.chars.sort]
  puts
  puts (space + digit.onoff(is['a'], :red, :black) * 4 + space) 
  2.times do
    if wires.chars.include?("b")
      print (digit.red + (space * 4)) 
    else
      print (digit.black + (space * 4)) 
    end
    if wires.chars.include?("c")
      puts (digit.red) 
    else
      puts (digit.black) 
    end
  end
  if wires.chars.include?("d")
    puts (space + digit.red * 4 + space) 
  else
    puts (space + digit.black * 4 + space) 
  end
  2.times do
    if wires.chars.include?("e")
      print (digit.red + (space * 4)) 
    else
      print (digit.black + (space * 4)) 
    end
    if wires.chars.include?("f")
      puts (digit.red) 
    else
      puts (digit.black) 
    end
  end
  if wires.chars.include?("g")
    puts (space + digit.red * 4 + space) 
  else
    puts (space + digit.black * 4 + space) 
  end
end

class Display
  def on(wires)
    system("clear")
    ["█", "▓", "▒", "░"].each do |f|
      system('clear')
      display("", digitz)
      sleep 0.035
    end
    ["█", "▓", "▒", "░"].reverse.each do |f|
      system("clear")
      display(wires, f)
      sleep 0.133
    end
  end
end

puzzle '8.1', mode: test do |input|
  input.each do |display|
    signal_pats, output = *display.split(' | ')
    puts signal_pats
    signal_pats.split(' ').each do |signal_pat|
      display(signal_pat, digitz)
    end
    Display.new.on("abcdefg")
    Display.new.on("acf")
    exit
  end
end