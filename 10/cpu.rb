#!/usr/bin/env ruby

class CPU
  def initialize
    @cycles = 0
    @x = 1
    @signal_strengths = []
  end

  def run(file_name)
    program = File.readlines(file_name, chomp: true)
    program.each do |command|
      instruction, arg = command.split
      arg = arg.to_i if arg

      eval_instruction(instruction, arg)
    end
  end

  def total_signal_strength
    @signal_strengths.sum
  end

  private

  def eval_instruction(instruction, arg)
    case instruction
    when 'noop'
      tic
    when 'addx'
      2.times { tic }
      @x += arg
    end
  end

  def tic
    @cycles += 1
    @signal_strengths << @cycles * @x if ((@cycles - 20) % 40).zero?
  end
end

cpu = CPU.new

cpu.run('input')

p cpu.total_signal_strength
