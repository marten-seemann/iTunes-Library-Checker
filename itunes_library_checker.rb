#!/usr/bin/env ruby

require 'Plist'
require 'uri'

filename = File.expand_path('~/Music/iTunes/iTunes Music Library.xml')

if !File.exists?(filename) then
  puts "Could not find the iTunes library file: #{filename}"
  puts "Quitting"
  exit
end


puts "Starting to parse your iTunes configuration file: #{filename}"
puts "This may take a while if you have a large library..."
puts 
puts "The following tracks are in your iTunes library file, but do not exist on your disk:"
puts

result = Plist::parse_xml(filename)

result.each do |key,value|
  next if key!="Tracks"
  value.each do |tracknum,value2|
    # puts "Processing track #{tracknum}"
    value2.each do |key3,value3|
      next if key3!="Location"
      path=value3.gsub("file://localhost","")
      path=URI.decode(path)
      if !File.exists?(path)
         puts path
      end
    end
  end
end
