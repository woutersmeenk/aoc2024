# frozen_string_literal: true

require 'active_support/all'

example = File.readlines('day7-example.txt', chomp: true)
input = File.readlines('day7.txt', chomp: true)

def sum_of_valid(lines, concat_allowed: false)
  lines.sum do |line|
    test, nums = line.split(':')
    test = test.to_i
    nums = nums.split.map(&:to_i)
    check_operators(test, nums, 0, 0, concat_allowed) ? test : 0
  end
end

def check_operators(test, nums, current, sum, concat_allowed)
  return sum == test if current >= nums.length # No more numbers just check if the sum is correct
  return false if sum > test # Already too big, so the sum can never be correct (it will only increase)

  return true if check_operators(test, nums, current + 1, sum + nums[current], concat_allowed)

  if concat_allowed && check_operators(test, nums, current + 1, (sum.to_s + nums[current].to_s).to_i, concat_allowed)
    return true
  end

  true if check_operators(test, nums, current + 1, sum * nums[current], concat_allowed)
end

puts "Example part 1: #{sum_of_valid(example)}"
puts "Part 1: #{sum_of_valid(input)}"

puts "Example part 2: #{sum_of_valid(example, concat_allowed: true)}"
puts "Part 2: #{sum_of_valid(input, concat_allowed: true)}"
