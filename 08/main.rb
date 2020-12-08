require_relative "../helpers"

# OldRange = (OldMax - OldMin)
# NewRange = (NewMax - NewMin)
# NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin

$errors = 0
$fork = 0
$logs = []
def evaluate(input, i, ran, acc, override = nil, depth = 0)
  fail "you've delved too deep" if depth > 1
  oldr = (input.length - 0)
  newr = (100 - 0)
  error = false
  log = Array.new(($logs.last || []).length)
  $logs.push(log)
  log << ["new", "", 0, 0, i]
  while i < input.length
    val = ((ran.length * newr) / oldr)
    # system("clear")
    # print "| %d errors |#{"=" * val} (#{val})/(%d)" % [$errors, ran.length]
    max = $logs.max_by { |x| x.length }.length
    str = "[%3d]|%3s %1s%3d|%4d|%3s idx|"
    # Array(0..max).each do |n|
    #   $logs[0..5].each.with_index do |logger, log_idx|
    #     print str % [log_idx.succ, logger[n]].flatten
    #   rescue
    #     print str % [log_idx.succ, "", "", 0, 0, ""].flatten
    #   end
    #   print "\n"
    # end
    line = input[i].match(/(nop|acc|jmp) (-|\+)(\d{1,3})/)
    cmd = override || line[1]
    sig = line[2]
    num = line[3].to_i

    # print "| %s %s%3d | %3d | %3s | " % [cmd, sig, num, acc, ran.include?(i) ? i.to_s.red : i]
    log << [override ? cmd.green : cmd, sig, num, acc, ran.include?(i) ? i.to_s.red : i]
    override = nil
    if ran.include?(i)
      puts "ERRRRRRRRRRRRRRRRRRRR"
      $errors += 1
      error = true
      break
    end

    case cmd
    when "nop"
      if depth < 1
        $fork += 1
        evaluate(input, i, ran.dup, acc.dup, "jmp", depth + 1)
      end
      next_i = i + 1
    when "acc"
      acc += (num * (sig == "-" ? -1 : 1))
      next_i = i + 1
    when "jmp"
      if depth < 1
        $fork += 1
        evaluate(input, i, ran.dup, acc.dup, "nop", depth + 1)
      end
      next_i = i + (num * (sig == "-" ? -1 : 1))
      # print "(%s%s) %s" % [sig, num, next_i]
    else
      puts "err"
    end

    ran << i
    i = next_i
  end
  unless error
    puts "COMPLETE #{$fork}"
    puts acc
  end
  puts "FINISHED WITH ERR", acc
  acc
end

puzzle "8.1" do |input|
  acc = evaluate(input, 0, [], 0)
  str = "[%3d]|%3s %1s%3d|%4d|%3s idx|"
  max = $logs.max_by { |x| x.length }.length
  Array(0..max).each do |n|
    $logs.each.with_index do |logger, log_idx|
      print str % [log_idx.succ, logger[n]].flatten
    rescue
      print " " * 28
    end
    print "\n"
  end
  puts $fork
  puts acc
end
