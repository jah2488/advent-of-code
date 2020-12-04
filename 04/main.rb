require_relative "../helpers"

FIELDS = {
  "byr" => {
    validate: true,
    length: 4,
    min: 1920,
    max: 2002
  },
  "iyr" => {
    validate: true,
    length: 4,
    min: 2010,
    max: 2020
  },
  "eyr" => {
    validate: true,
    length: 4,
    min: 2020,
    max: 2030
  },
  "hgt" => {
    validate: true,
    subfield: true,
    in: {
      min: 59,
      max: 76
    },
    cm: {
      min: 150,
      max: 193
    },
    format: /[0-9]{2,3}(cm|in)/
  },
  "hcl" => {
    validate: true,
    length: 7,
    format: /#[0-9a-fA-F]{6}/
  },
  "ecl" => {
    validate: true,
    length: 3,
    in_set: %(amb blu brn gry grn hzl oth)
  },
  "pid" => {
    validate: true,
    length: 9,
    format: /[0-9]+/
  },
  "cid" => {validate: false}
}

def valid?(field, value)
  v = FIELDS[field]
  return true unless v[:validate]
  return false if v[:length] && !(v[:length] == value.length)
  return false if v[:format] && !v[:format].match(value)
  return false if v[:in_set] && !v[:in_set].include?(value)
  return false if v[:min] && (value.to_i < v[:min])
  return false if v[:max] && (value.to_i > v[:max])
  if v[:subfield]
    sf = v[:format].match(value)
    return false if sf.nil?
    return false if v[sf[1].to_sym][:min] > value.to_i
    return false if v[sf[1].to_sym][:max] < value.to_i
  end
  true
end

def validate_passports(input, count, strict = false)
  passports = input.split("\n\n")
  passports.each do |pass|
    pass_hash = Hash[pass.split("\n").flat_map { |x| x.split(" ").map { |s| s.split(":") } }]
    if [["cid"], []].include?(FIELDS.keys - pass_hash.keys)
      if strict
        if pass_hash.all? { |(field, value)| valid?(field, value) }
          count += 1
        end
      else
        count += 1
      end
    end
  end
  count
end

puzzle "4.1", mode: :count, input: :raw, answer: 239 do |input, count|
  puts validate_passports(input, count, false)
end

puzzle "4.2", mode: :count, input: :raw, answer: 188 do |input, count|
  puts validate_passports(input, count, true)
end
