def input(file_name)
  File.open(file_name).readlines
end

def puzzle(name, mode: :count, answer: nil)
  dir = "0" + name.split('.').first
  file_name = [dir, "input.txt"].join('/')
  puts "---- starting  #{name} ----"
  case mode
  when :count then yield(input(file_name), 0)
  when :find  then yield(input(file_name), false)
  else;            yield(input(file_name))
  end
  puts answer
  puts "---- finishing #{name} ----"
  puts
end
