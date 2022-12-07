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

def find(dir, coll = [], &block)
  dir.map do |name, contents|
    if contents.is_a?(Hash) && name != :_meta
      find(contents, coll, &block) 
      if block.call(contents) 
        coll.push(contents)
      end
    end
  end
  coll
end

TOTAL_DISK_SPACE  = 70_000_000
NEEDED_DISK_SPACE = 30_000_000
MAX = 100_000

xpuzzle '7.1', mode: :count, answer: 1583951 do |input, total|
  dir_stack = []
  fs = { "/" => {}}
  input.each do |line|
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
  find(fs["/"]).reduce(0) { |sum, dir| sum += du(dir) }
end

puzzle '7.2', mode: :count, answer: 214171 do |input, total|
  dir_stack = []
  fs = { "/" => {}}
  input.each do |line|
    if line.scan(/\$ ls/).first
    end

    if line.scan(/dir (.+)/).first
      cwd = fs.dig(*dir_stack)
      dir = line.scan(/dir (.+)/).first.first
      cwd[dir] ||= {}
    end

    if line.scan(/(\d+) (.+)/).first
      cwd = fs.dig(*dir_stack)
      file = line.scan(/(\d+) (.+)/).first
      cwd[:_meta] ||= {}
      cwd[:_meta][:size] ||= 0
      cwd[:_meta][:size] += file[0].to_i
      cwd[:_meta][:name] ||= dir_stack.last
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
  puts "Total Disk Space: #{TOTAL_DISK_SPACE}"
  puts "Used Disk Space: #{du(fs["/"])}"
  warn "---"
  puts "Disk Space To Free: #{NEEDED_DISK_SPACE - (TOTAL_DISK_SPACE - du(fs["/"]))}"
  needed = NEEDED_DISK_SPACE - (TOTAL_DISK_SPACE - du(fs["/"]))
  find(fs) { |contents| du(contents) > needed }.sort_by { |dir| du(dir) }.first
end
