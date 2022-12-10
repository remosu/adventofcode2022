#!/usr/bin/env ruby

grid = File.readlines("input", chomp: true).map { |line| line.chars.map(&:to_i) }

H = grid.length
W = grid[0].length

scenic_scores = H.times.map { [0] * W }

grid.each_with_index do |row, i|
  row.each_with_index do |tree_size, j|
    l = 0
    (i - 1).downto(0) do |n|
      l += 1
      break if tree_size <= grid[n][j]
    end
    r = 0
    (i + 1).upto(W - 1) do |n|
      r += 1
      break if tree_size <= grid[n][j]
    end
    u = 0
    (j - 1).downto(0) do |n|
      u += 1
      break if tree_size <= grid[i][n]
    end
    d = 0
    (j + 1).upto(H - 1) do |n|
      d += 1
      break if tree_size <= grid[i][n]
    end
    scenic_scores[i][j] = l * r * u * d
  end
end

p scenic_scores.flatten.max
