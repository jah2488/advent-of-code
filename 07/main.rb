require_relative "../helpers"

# parse rules line by line
# aggregate rules by bag type
# write a solver to give the bag count given a bag
BAG_RE = "?,? ([0-9]+)?([^,.]*)bags?"
RULE_RE = ->(bags) do
  /(.*) bags contain (no other bags.|(\d)([^.,]*)bags?#{BAG_RE * bags})/
end

def id_for(bag)
  bag.strip.tr(" ", "_").to_sym
end

def resolve_for(rules, target_bag, excluding = [])
  containers = rules.select { |bag, v| (v[:can_contain] || []).include?(target_bag) }
  return excluding if containers.empty?
  containers.flat_map { |bag, _| resolve_for(rules, bag, excluding | containers.keys) }
end

def bags_for(rules, target_bag, including = [], count = 1)
  containers = rules[target_bag][:can_contain]
  return count if containers.empty?
  containers.map { |name, c| bags_for(rules, name, including | [name], c) * count }.sum + count
end

puzzle "7.1" do |input|
  rules = {}
  input.each do |rule|
    tokens = rule.chomp.match(RULE_RE[rule.count(",")])
    container = id_for(tokens[1])
    sub_bags = if tokens[2] == "no other bags."
      {}
    else
      tokens[3..-1].each_slice(2).map { |bag| [id_for(bag[1]), bag[0].to_i] }.to_h
    end
    rules[container] ||= {}
    rules[container][:can_contain] ||= {}
    rules[container][:can_contain].merge!(sub_bags)
    sub_bags.keys.each do |bag|
      rules[bag] ||= {}
      rules[bag][:can_be_contained_by] ||= []
      rules[bag][:can_be_contained_by] |= [container]
    end
  end
  puts resolve_for(:shiny_gold).uniq.count
  puts bags_for(:shiny_gold) - 1
end
