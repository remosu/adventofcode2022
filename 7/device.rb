#!/usr/bin/env ruby

class Device
  def initialize
    @root_dir = Dir.new("/")
    @current_dir = @root_dir
  end

  def load(file_name)
    commands = File.read(file_name).split("$ ").map { |v| v.split("\n") }[1..]
    commands.each do |command|
      input, *output = command
      case input.split
      in ["cd", directory_name]
        case directory_name
        when "/"
          @current_dir = @root_dir
        when ".."
          @current_dir = @current_dir.parent
        else
          @current_dir = @current_dir.find(directory_name)
        end
      in["ls"]
        output.each do |line|
          case line.split
          in ["dir", directory_name]
            @current_dir.add_directory(directory_name)
          in [size, file_name]
            @current_dir.add_file(file_name, size.to_i)
          end
        end
      end
    end
    p @root_dir.all_dirs.select { |d| d.size <= 100000 }.map(&:size).sum
  end
end

class Dir
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
    @items = []
  end

  def find(directory_name)
    @items.find { |d| d.name == directory_name }
  end

  def add_directory(directory_name)
    Dir.new(directory_name).tap do |new_directory|
      new_directory.parent = self
      @items << new_directory
    end
  end

  def add_file(file_name, size)
    @items << XFile.new(file_name, size)
  end

  def size
    @items.map(&:size).sum
  end

  def inspect
    "#{name}[#{size}]: #{@items.inspect}"
  end

  def all_dirs
    dirs = @items.select { |item| item.is_a?(Dir) }
    dirs.map(&:all_dirs).sum([self])
  end
end

class XFile
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def inspect
    "#{name}[#{size}]"
  end
end

device = Device.new

device.load("input")
