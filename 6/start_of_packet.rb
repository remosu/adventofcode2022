#!/usr/bin/env ruby


def characters_before_first_marker(datastream_buffer, size: 4)
  datastream_buffer.chars.each_index do |i|
    return i + size if datastream_buffer[i...i + size].chars.uniq.count == size
  end
end

datastream_buffer = File.read("input").chomp

p characters_before_first_marker(datastream_buffer)
p characters_before_first_marker(datastream_buffer, size: 14)
