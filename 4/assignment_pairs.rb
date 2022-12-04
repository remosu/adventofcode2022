#!/usr/bin/env ruby

p File.readlines("input")
      .map { |line| line.strip.split(',').map { |pair| Range.new(*pair.split('-').map(&:to_i)) } }
      .select { |r1, r2| r1.cover?(r2) || r2.cover?(r1) }
      .count
