require_relative '../helpers'
require 'set'

def test
  [
    "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)\n",
    "trh fvjkl sbzzf mxmxvkd (contains dairy)\n",
    "sqjhc fvjkl (contains soy)\n",
    "sqjhc mxmxvkd sbzzf (contains fish)\n",
  ]
end

puzzle '21' do |input|
  ingreds = []
  a2i = Hash.new { |h, k| h[k] = []}
  opts = {}
  dets = {}
  input.each do |food|
    match = food.match(/(.*) \(contains ([^)]*)/)
    ingredients = match[1].split(' ')
    allergens   = match[2].split(', ')

    ingreds.concat(ingredients)
    allergens.each { |a| a2i[a] << ingredients }

    a2i.keys.count.times do
      a2i.each do |(allergen, values)|
        opts[allergen] = values.reduce(:&) - dets.values.flatten
        if opts[allergen].length == 1
          dets[allergen] = opts[allergen]
        end
      end
    end
  end

  puts ingreds.flatten.count { |i| !dets.values.flatten.uniq.sort.include?(i) }
  puts dets.sort_by { |(k, v)| k }.map(&:last).join(",")
  binding.pry
end