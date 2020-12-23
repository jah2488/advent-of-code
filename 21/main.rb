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
  allergs = []
  i2a = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = 0 }}
  a2i = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = 0 }}
  foods = Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = 0 }}
  p = {}
  d = {}
  input.each.with_index do |food, idx|
    match = food.match(/(.*) \(contains ([^)]*)/)
    ingredients = match[1].split(' ')
    allergens   = match[2].split(', ')
    foods[allergens][:ingredients] = ingredients
    ingredients.each do |i|
      # foods[allergens][i] += 1
    end
    ingredients.each do |i|
      ingreds << i
      i2a[i][idx] = allergens
      allergens.each do |a|
        #i2a[i][a] += 1
      end
    end
    allergens.each do |a|
      allergs << a
      a2i[a][idx] = ingredients
      ingredients.each do |i|
        #a2i[a][i] += 1
      end
    end
    a2i.keys.flatten.uniq.count.times do
      a2i.each do |(allergen, values)|
        p[allergen] = values.values.reduce(:&) - d.values.flatten
        if p[allergen].length == 1
          d[allergen] = p[allergen]
        end
      end
    end
    puts ingreds.flatten.count { |i| !d.values.flatten.uniq.sort.include?(i) }
    puts d.sort_by { |(k, v)| k }.map(&:last).join(",")
  end
  binding.pry
end