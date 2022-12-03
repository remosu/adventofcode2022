#!/usr/bin/env ruby

priorities = Hash[("a".."z").map { |c| [c, c.ord - 96] } + ("A".."Z").map { |c| [c, c.ord - 38] }]

def find_error_item(rucksack)
  length = rucksack.length
  compartment_1 = rucksack[0...length/2]
  compartment_2 = rucksack[length/2...length]

  compartment_1
    .chars
    .intersection(compartment_2.chars)
    .first
end

rucksacks = File.readlines("input").map(&:strip)
result = rucksacks.map { |rucksack| priorities[find_error_item(rucksack)] }.sum

p result
