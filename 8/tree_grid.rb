#!/usr/bin/env ruby

require 'set'

i = 0
j = 0
t = [-1]
b = []
l = -1
r = []

v = Set.new

File.new('input').each_char do |c|
  if c == "\n"
    r.each { |_, p| v.add(p) }
    l = -1
    r = []
    i += 1
    j = 0
  else
    t[j] ||= -1
    b[j] ||= []
    c = c.to_i

    if c > t[j]
      t[j] = c
      v.add([i, j])
    end

    if c > l
      l = c
      v.add([i, j])
    end

    b[j].delete_if { |x, _| x <= c }
    b[j] << [c, [i, j]]

    r.delete_if { |x, _| x <= c }
    r << [c, [i, j]]

    j += 1
  end
end

b.each do |x|
  x.each { |_, p| v.add(p) }
end

p v.count
