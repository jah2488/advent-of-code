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
    if contents.is_a?(Hash)
      sum += du(contents)
    else
      sum += contents.to_i
    end
  end
end

def find(dir, coll = [], &block)
  dir.map do |name, contents|
    if contents.is_a?(Hash)
      find(contents, coll, &block) 
      coll.push(contents) if block.call(contents) 
    end
  end
  coll
end

TOTAL_DISK_SPACE  = 70_000_000
NEEDED_DISK_SPACE = 30_000_000
MAX = 100_000

puzzle '7.1', mode: :count, answer: 1583951 do |input, total|
  dir_stack = []
  fs = { "/" => {}}
  input.each do |line|
    dir_re  = /dir (.+)/
    file_re = /(\d+) (.+)/
    cd_re   = /\$ cd (.+)/

    if dir_re.match(line)
      cwd = fs.dig(*dir_stack)
      dir = line.scan(/dir (.+)/).first.first
      cwd[dir] ||= {}
    end

    if file_re.match(line)
      cwd = fs.dig(*dir_stack)
      file = line.scan(/(\d+) (.+)/).first
      cwd[:_name] ||= dir_stack.last
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
  end
  find(fs["/"]) { |c| du(c) < MAX }.reduce(0) { |sum, dir| sum += du(dir) }
end

puzzle '7.2', mode: :count, answer: 214171 do |input, total|
  dir_stack = []
  fs = { "/" => {}}
  input.each do |line|
    if line.scan(/dir (.+)/).first
      cwd = fs.dig(*dir_stack)
      dir = line.scan(/dir (.+)/).first.first
      cwd[dir] ||= {}
    end

    if line.scan(/(\d+) (.+)/).first
      cwd = fs.dig(*dir_stack)
      file = line.scan(/(\d+) (.+)/).first
      cwd[:_name] ||= dir_stack.last
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
  end
  needed = NEEDED_DISK_SPACE - (TOTAL_DISK_SPACE - du(fs["/"]))
  du(find(fs) { |contents| du(contents) > needed }.sort_by { |dir| du(dir) }.first)
end
