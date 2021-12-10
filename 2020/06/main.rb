require_relative "../helpers"

QUESTIONS = Array("a".."z")

puzzle "6.1", mode: :count, input: :raw do |input, count|
  input
    .split("\n\n")
    .reduce(0) { |sum, group| sum + (QUESTIONS & group.delete("\n").chars).count }
end

puzzle "6.1", mode: :count, input: :raw do |input, count|
  input
    .split("\n\n")
    .map { |group| group.split("\n").map(&:chars).reduce(&:&) }
    .compact
    .reduce(0) { |sum, group| sum + group.count }
end
