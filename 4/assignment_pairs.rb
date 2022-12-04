#!/usr/bin/env ruby

secction_assignments =
  File.readlines("input")
      .map { |line| line.strip.split(',').map { |pair| Range.new(*pair.split('-').map(&:to_i)) } }

p secction_assignments.select { |r1, r2| r1.cover?(r2) || r2.cover?(r1) }
                      .count

p secction_assignments.select { |r1, r2| r1.cover?(r2.begin) || r2.cover?(r1.begin) }
                      .count
