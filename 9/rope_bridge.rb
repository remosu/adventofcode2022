#!/usr/bin/env ruby

require 'set'

motions = File.readlines('input', chomp: true)

h = [0, 0]
t = [0, 0]
tail_positions = Set.new([[0, 0]])

motions.each do |motion|
  direction, steps = motion.split
  steps = steps.to_i
  case direction
  when 'R'
    h[0] += steps
  when 'L'
    h[0] -= steps
  when 'U'
    h[1] -= steps
  when 'D'
    h[1] += steps
  end

  while [0, 1].any? { |i| (h[i] - t[i]).abs > 1 }
    v = [h[0] - t[0], h[1] - t[1]]
    [0, 1].each do |i|
      v[i] = v[i] / v[i].abs unless v[i].zero?
      t[i] += v[i]
    end
    tail_positions.add([t[0], t[1]])
  end
end

p tail_positions.count
