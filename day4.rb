# frozen_string_literal: true

require 'active_support/all'

example = File.readlines('day4-example.txt', chomp: true)
input = File.readlines('day4.txt', chomp: true)

def check_letter(grid, x, y, letter) # rubocop:disable Naming/MethodParameterName
  return false if x.negative? || x > grid.first.size - 1
  return false if y.negative? || y > grid.size - 1

  grid[y][x] == letter
end

def part1(grid)
  word = 'XMAS'
  height = grid.size
  width = grid.first.size
  (0..height - 1).sum do |y|
    (0..width - 1).sum do |x|
      next 0 unless grid[y][x] == word[0]

      [
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0],
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
      ].count do |dir|
        (1..word.size - 1).all? do |dist|
          check_letter(
            grid,
            x + (dir[0] * dist),
            y + (dir[1] * dist),
            word[dist],
          )
        end
      end
    end
  end
end

puts "Example part 1: #{part1(example)}"
puts "Part 1: #{part1(input)}"

def part2(grid)
  height = grid.size
  width = grid.first.size
  (0..height - 1).sum do |y|
    (0..width - 1).sum do |x|
      next 0 unless grid[y][x] == 'A'

      if check_letter(grid, x - 1, y - 1, 'S')
        next 0 unless check_letter(grid, x + 1, y + 1, 'M')
      elsif check_letter(grid, x - 1, y - 1, 'M')
        next 0 unless check_letter(grid, x + 1, y + 1, 'S')
      else
        next 0
      end

      if check_letter(grid, x + 1, y - 1, 'S')
        next 0 unless check_letter(grid, x - 1, y + 1, 'M')
      elsif check_letter(grid, x + 1, y - 1, 'M')
        next 0 unless check_letter(grid, x - 1, y + 1, 'S')
      else
        next 0
      end

      1
    end
  end
end

puts "Example part 2: #{part2(example)}"
puts "Part 2: #{part2(input)}"
