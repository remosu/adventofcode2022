#!/usr/bin/env ruby

require 'set'

DIRECTIONS = {
  'R' => [0, 1],
  'L' => [0, -1],
  'U' => [1, -1],
  'D' => [1, 1]
}

motions = File.readlines('input', chomp: true)

knots = 10.times.map { [0, 0] }
tail_positions = Set.new([[0, 0]])

motions.each do |motion|
  direction, steps = motion.split
  steps = steps.to_i
  axis, d = DIRECTIONS[direction]

  steps.times do
    knots[0][axis] += d

    9.times do |j|
      h = knots[j]
      t = knots[j + 1]
      next if h.zip(t).all? { |x, y| (x - y).abs <= 1 }

      v = [h[0] - t[0], h[1] - t[1]]
      [0, 1].each do |i|
        v[i] = v[i] / v[i].abs unless v[i].zero?
        t[i] += v[i]
      end

    end
    tail_positions.add(knots[-1].dup)
  end
end

p tail_positions.count
