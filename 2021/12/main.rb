require_relative '../helpers'

def test
    #10
    [
        "start-A\n",
        "start-b\n",
        "A-c\n",
        "A-b\n",
        "b-d\n",
        "A-end\n",
        "b-end\n",
    ]
end

def test2
    #19
    [
        "dc-end\n",
        "HN-start\n",
        "start-kj\n",
        "dc-start\n",
        "dc-HN\n",
        "LN-dc\n",
        "HN-end\n",
        "kj-sa\n",
        "kj-HN\n",
        "kj-dc\n",
    ]
end

def test3
    #226
    [
        "fs-end\n",
        "he-DX\n",
        "fs-he\n",
        "start-DX\n",
        "pj-DX\n",
        "end-zg\n",
        "zg-sl\n",
        "zg-pj\n",
        "pj-he\n",
        "RW-he\n",
        "fs-DX\n",
        "pj-RW\n",
        "zg-RW\n",
        "start-pj\n",
        "he-WI\n",
        "zg-he\n",
        "pj-fs\n",
        "start-RW\n",
    ]
end

def print_node(graph, node)
  return if node.visited

  node.visited = true
  print node.name
  print " -- "
  node.nodes.each do |n|
    print_node(graph, n)
  end
  puts
end

class Node
    attr_accessor :name, :nodes, :visited
    def initialize(name, nodes = [])
      @name = name
      @nodes = nodes
      @visited = false
    end

    def ending?
      nodes.reject(&:visited).count.zero?
    end

    def display(depth = 1)
        return if @visited

        @visited = true
        print name 
        if self.ending?
            print "\n" 
        else
            print " \\ \n"
        end
        nodes.each do |node|
            depth_spacer = "    "
            next if node.visited
            if node != nodes.last
                print ((depth_spacer) * depth) + "| "
            else
                print (depth_spacer * (depth)) + "\\ "
            end
            node.display(depth + 1)
        end
        @visited = false
    end
    def inspect
      "#{nodes.map {|n| n.name }}"
    end
end

puzzle '12', mode: test do |input|
    graph = Hash.new { |h, k| h[k] = Node.new(k) }
    input.each do |line|
      a, b = *line.chomp.split("-")
      graph[a].nodes << graph[b]
      graph[b].nodes << graph[a]
    end
    binding.pry
    print_node(graph, 'start', [])
end