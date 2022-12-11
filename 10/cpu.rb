#!/usr/bin/env ruby

class CPU
  def initialize
    @cycles = 0
    @x = 1
    @signal_strengths = []
    @pixel_position = 0
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
    render_pixel
  end

  def render_pixel
    if (@pixel_position - @x).abs <= 1
      print '#'
    else
      print '.'
    end
    if @pixel_position == 39
      @pixel_position = 0
      print "\n"
    else
      @pixel_position += 1
    end
  end
end

cpu = CPU.new

cpu.run('input')

p cpu.total_signal_strength
