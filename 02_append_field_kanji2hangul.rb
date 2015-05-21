#!/usr/bin/ruby -Ku

hanja2hangul = {}
kanji_new2old = {}

open("data/00_hanja2hangul.csv") do |f|
  f.each do |line|
    record = line.chomp.split(',')
    hanja2hangul[record[0]] = record[1]
  end
end
open("data/00_kanji_old_new.csv") do |f|
  f.each do |line|
    record = line.chomp.split(',')
    kanji_new2old[record[1]] = record[0]
  end
end


STDIN.each do |line|
  # parsing
  record = line.chomp.split(',')
  hangul_array = []
  record[0].split('').each do |char|
    char = kanji_new2old[char] if kanji_new2old[char]
    output_char = hanja2hangul[char]
#    output_char = char if output_char == nil
    next if output_char == nil
    hangul_array << output_char
  end
  puts [record,hangul_array.join('')].flatten.join(',')
end
