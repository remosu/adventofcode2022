#!/usr/bin/env ruby

class CraneStacks
  def initialize(path)
    @lines = File.readlines(path, chomp: true)
    @stacks = []
  end

  def cranes_at_top
    process_stacks_row_at(0)
    p @stacks.map(&:last).join
  end

  private

  def process_stacks_row_at(position)
    line = @lines[position]
    return process_move(position + 2) if line.start_with?(" 1")

    line.chars.each_with_index.filter_map { |c, i| [(i - 1) / 4, c] if ("A".."Z").include?(c) }.each do |i, v|
      @stacks[i] ||= []
      @stacks[i].prepend(v)
    end

    process_stacks_row_at(position + 1)
  end

  def process_move(position)
    line = @lines[position]
    return unless line

    quantity, from, to = line.scan(/\d+/).map(&:to_i)
    quantity.times do
      @stacks[to - 1].append(@stacks[from - 1].pop)
    end

    process_move(position + 1)
  end
end

crane_stacks = CraneStacks.new("input")

crane_stacks.cranes_at_top
