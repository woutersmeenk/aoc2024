# frozen_string_literal: true

require 'active_support/all'

example = File.readlines('day2-example.txt', chomp: true)
input = File.readlines('day2.txt', chomp: true)

def safe(levels)
  increments = levels.zip(levels[1..]).map { |p, c| c ? p - c : nil }.compact
  in_range = increments.all? { |i| (i >= 1 && i <= 3) || (i >= -3 && i <= -1) }
  all_same = increments.all?(&:positive?) || increments.all?(&:negative?)
  in_range && all_same
end

def safe_reports(lines)
  lines.map(&:split).map do |l|
    safe(l.map(&:to_i))
  end.count(true)
end

puts "Example part 1: #{safe_reports(example)}"
puts "Part 1: #{safe_reports(input)}"

def safe_reports2(lines)
  lines.map(&:split).map do |l|
    l = l.map(&:to_i)
    next true if safe(l)

    (0..l.length).any? do |i|
      safe(l.dup.tap { |d| d.delete_at(i) })
    end
  end.count(true)
end

puts "Example part 2: #{safe_reports2(example)}"
puts "Part 2: #{safe_reports2(input)}"
