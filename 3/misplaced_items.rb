#!/usr/bin/env ruby

priorities = Hash[("a".."z").map { |c| [c, c.ord - 96] } + ("A".."Z").map { |c| [c, c.ord - 38] }]

rucksacks = File.readlines("input").map(&:strip).map(&:chars)

def find_item_batch_for(group)
  rucksack, *others_rucksacks = group
  rucksack.intersection(*others_rucksacks).first
end

result = rucksacks
           .each_slice(3)
           .map { |group| find_item_batch_for(group) }
           .map { |item_batch| priorities[item_batch] }
           .sum

p result
