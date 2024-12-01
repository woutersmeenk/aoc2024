# frozen_string_literal: true

require 'active_support/all'

example = File.readlines('day1-example.txt', chomp: true)
input = File.readlines('day1.txt', chomp: true)

def dist_sum(lines)
  pairs = lines.map(&:split)
  list1 = pairs.map(&:first).map(&:to_i).sort
  list2 = pairs.map(&:second).map(&:to_i).sort
  list1.zip(list2).map { |a, b| (a - b).abs }.sum
end

puts "Example part 1: #{dist_sum(example)}"
puts "Part 1: #{dist_sum(input)}"

def similarity_score(lines)
  pairs = lines.map(&:split)
  left = pairs.map(&:first).map(&:to_i)
  right = pairs.map(&:second).group_by(&:to_i).transform_values(&:count)
  left.map { |i| i * (right[i] || 0) }.sum
end

puts "Example part 2: #{similarity_score(example)}"
puts "Part 2: #{similarity_score(input)}"
