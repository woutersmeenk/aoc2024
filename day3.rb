# frozen_string_literal: true

require 'active_support/all'
require 'strscan'

example = File.readlines('day3-example.txt', chomp: true)
example2 = File.readlines('day3-example2.txt', chomp: true)
input = File.readlines('day3.txt', chomp: true)

def parser(lines, conditionals_enabled: false)
  sum = 0
  enabled = true
  lines.each do |l|
    s = StringScanner.new(l)
    loop do
      break if s.eos?

      if s.skip('mul(')

        next unless (a = s.scan(/[0-9]{1,3}/))
        next unless s.skip(',')
        next unless (b = s.scan(/[0-9]{1,3}/))
        next unless s.skip(')')

        sum += a.to_i * b.to_i if enabled
      elsif s.skip('do()')
        enabled = true if conditionals_enabled
      elsif s.skip("don't()")
        enabled = false if conditionals_enabled
      else
        s.getch
      end
    end
  end
  sum
end

puts "Example part 1: #{parser(example)}"
puts "Part 1: #{parser(input)}"
puts "Example part 2: #{parser(example2, conditionals_enabled: true)}"
puts "Part 2: #{parser(input, conditionals_enabled: true)}"
