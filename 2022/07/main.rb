def test
  puts "--- Test Data In Use ---".italic.yellow
  [
    "$ cd /",
    "$ ls",
    "dir a",
    "14848514 b.txt",
    "8504156 c.dat",
    "dir d",
    "$ cd a",
    "$ ls",
    "dir e",
    "29116 f",
    "2557 g",
    "62596 h.lst",
    "$ cd e",
    "$ ls",
    "584 i",
    "$ cd ..",
    "$ cd ..",
    "$ cd d",
    "$ ls",
    "4060174 j",
    "8033020 d.log",
    "5626152 d.ext",
    "7214296 k",
  ]
end

def du(dir)
  dir.reduce(0) do |sum, (name, contents)|
    next sum if name == :_meta
    if contents.is_a?(Hash)
      sum += du(contents)
    else
      sum += contents.to_i
    end
  end
end

def find(dir)
  dir.flat_map do |dir_name, dir_contents|
    Array(if dir_name != :_meta && dir_contents.is_a?(Hash)
      find(dir_contents)
    end) + Array(dir.select do |name, contents|
      name != :_meta && contents.is_a?(Hash) && du(contents) <= 100_000
    end)
  end.compact
end

puzzle '7.1', mode: :count, answer: nil do |input, total|
  dir_stack = []
  fs = { "/" => {}}
  test.each do |line|
    print dir_stack.join("/").bold + " "
    puts line.bold.red
    puts fs.inspect.green

    if line.scan(/\$ ls/).first
    end

    if line.scan(/dir (.+)/).first
      cwd = fs.dig(*dir_stack)
      dir = line.scan(/dir (.+)/).first.first
      puts "--- adding dir '#{dir}' to #{dir_stack.last} ---".yellow
      cwd[dir] ||= {}
    end

    if line.scan(/(\d+) (.+)/).first
      cwd = fs.dig(*dir_stack)
      file = line.scan(/(\d+) (.+)/).first
      puts file.inspect
      cwd[:_meta] ||= {}
      cwd[:_meta][:size] ||= 0
      cwd[:_meta][:size] += file[0].to_i
      cwd[file[1]] ||= file[0]
    end

    if line.scan(/\$ cd (.+)/).first
      dir = line.scan(/\$ cd (.+)/).first.first
      if dir == ".."
        dir_stack.pop
      else
        dir_stack << dir
      end
    end
    puts "---\n".red
  end
  puts fs
  binding.pry
  nil
end

xpuzzle '7.2', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end
