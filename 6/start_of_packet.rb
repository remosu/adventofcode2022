#!/usr/bin/env ruby


def characters_before_first_marker(datastream_buffer, size: 4)
  i = 0
  until datastream_buffer[i...i + size].chars.uniq.count == size
    i += 1
  end
  i + size
end

datastream_buffer = File.read("input").chomp

p characters_before_first_marker(datastream_buffer)
p characters_before_first_marker(datastream_buffer, size: 14)
