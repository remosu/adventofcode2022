#!/usr/bin/env ruby

class CraneStacks
  def initialize(path)
    @stacks = []
    @input_file = File.open(path)
  end

  def cranes_at_top
    build_stacks
    read_line # empty line
    execute_moves

    p @stacks.map(&:last).join
  end

  private

  def build_stacks
    line = read_line
    until line.start_with?(" 1")
      line.length/4
      ((line.length + 1) / 4).times.filter_map { |i| v = line[4 * i + 1]; [i, v] if v != " " }.each do |i, v|
        @stacks[i] ||= []
        @stacks[i].prepend(v)
      end
      line = read_line
    end
  end

  def execute_moves
    line = read_line

    while line
      quantity, from, to = line.scan(/\d+/).map(&:to_i)
      @stacks[to - 1].concat(@stacks[from - 1].pop(quantity))

      line = read_line
    end
  end

  def read_line
    @input_file.gets&.chomp
  end
end

crane_stacks = CraneStacks.new("input")

crane_stacks.cranes_at_top
