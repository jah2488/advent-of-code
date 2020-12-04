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
    in: %(amb blu brn gry grn hzl oth)
  },
  "pid" => {
    validate: true,
    length: 9,
    format: /[0-9]+/
  },
  "cid" => {validate: false}
}
# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.
def valid?(field, value)
  validator = FIELDS[field]
  return true unless validator[:validate]
end

def validate_passports(input, count)
  passports = input.split("\n\n")
  passports.each do |pass|
    pass_hash = Hash[pass.split("\n").flat_map { |x| x.split(" ").map { |s| s.split(":") } }]
    puts pass_hash.inspect
    if FIELDS.keys - pass_hash.keys == [] || FIELDS.keys - pass_hash.keys == ["cid"]
      if pass_hash.all? { |(field, value)| valid?(field, value) }
        count += 1
      end
    end
  end
  count
end

puzzle "4.1", mode: :count, input: :raw, answer: 239 do |input, count|
  puts validate_passports(input, count)
end
