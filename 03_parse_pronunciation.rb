#!/usr/bin/ruby -Ku

require 'json'
require 'romaji'

hangul_dic_json = '{
  "initial":
    [{"pronounce": "g", "letter_parsed": "ㄱ", "letter": "ㄱ", "pronounce_head": "k"}, {"pronounce": "kk", "letter_parsed": "ᄀᄀ", "letter": "ㄲ", "pronounce_head": "kk"}, {"pronounce": "n", "letter_parsed": "ㄴ", "letter": "ㄴ", "pronounce_head": "n"}, {"pronounce": "d", "letter_parsed": "ㄷ", "letter": "ㄷ", "pronounce_head": "t"}, {"pronounce": "tt", "letter_parsed": "ᄃᄃ", "letter": "ㄸ", "pronounce_head": "tt"}, {"pronounce": "r", "letter_parsed": "ㄹ", "letter": "ㄹ", "pronounce_head": "r"}, {"pronounce": "m", "letter_parsed": "ㅁ", "letter": "ㅁ", "pronounce_head": "m"}, {"pronounce": "b", "letter_parsed": "ㅂ", "letter": "ㅂ", "pronounce_head": "p"}, {"pronounce": "bb", "letter_parsed": "ㅂㅂ", "letter": "ㅃ", "pronounce_head": "pp"}, {"pronounce": "s", "letter_parsed": "ㅅ", "letter": "ㅅ", "pronounce_head": "s"}, {"pronounce": "ss", "letter_parsed": "ㅅㅅ", "letter": "ㅆ", "pronounce_head": "ss"}, {"pronounce": "", "letter_parsed": "ㅇ", "letter": "ㅇ", "pronounce_head": ""}, {"pronounce": "j", "letter_parsed": "ㅈ", "letter": "ㅈ", "pronounce_head": "ch"}, {"pronounce": "jj", "letter_parsed": "ㅈㅈ", "letter": "ㅉ", "pronounce_head": "tch"}, {"pronounce": "ch", "letter_parsed": "ㅊ", "letter": "ㅊ", "pronounce_head": "ch"}, {"pronounce": "k", "letter_parsed": "ㅋ", "letter": "ㅋ", "pronounce_head": "k"}, {"pronounce": "t", "letter_parsed": "ㅌ", "letter": "ㅌ", "pronounce_head": "t"}, {"pronounce": "p", "letter_parsed": "ㅍ", "letter": "ㅍ", "pronounce_head": "p"}, {"pronounce": "h", "letter_parsed": "ㅎ", "letter": "ㅎ", "pronounce_head": "h"}],
  "medial":
    [{"pronounce": "a", "letter_parsed_key": "ᅡ", "letter": "ᅡ", "letter_parsed_full": "ᅡ"}, {"pronounce": "ae", "letter_parsed_key": "ᅢ", "letter": "ᅢ", "letter_parsed_full": "ㅏㅣ"}, {"pronounce": "ya", "letter_parsed_key": "ᅣ", "letter": "ᅣ", "letter_parsed_full": "ᅣ"}, {"pronounce": "yae", "letter_parsed_key": "ᅤ", "letter": "ᅤ", "letter_parsed_full": "ㅑㅣ"}, {"pronounce": "eo", "letter_parsed_key": "ᅥ", "letter": "ᅥ", "letter_parsed_full": "ᅥ"}, {"pronounce": "e", "letter_parsed_key": "ᅦ", "letter": "ᅦ", "letter_parsed_full": "ㅓㅣ"}, {"pronounce": "yeo", "letter_parsed_key": "ᅧ", "letter": "ᅧ", "letter_parsed_full": "ᅧ"}, {"pronounce": "ye", "letter_parsed_key": "ᅨ", "letter": "ᅨ", "letter_parsed_full": "ㅕㅣ"}, {"pronounce": "o", "letter_parsed_key": "ᅩ", "letter": "ᅩ", "letter_parsed_full": "ᅩ"}, {"pronounce": "wa", "letter_parsed_key": "ᅩᅡ", "letter": "ᅪ", "letter_parsed_full": "ᅩᅡ"}, {"pronounce": "wae", "letter_parsed_key": "ᅩᅢ", "letter": "ᅫ", "letter_parsed_full": "ㅗㅏㅣ"}, {"pronounce": "oe", "letter_parsed_key": "ᅩᅵ", "letter": "ᅬ", "letter_parsed_full": "ᅩᅵ"}, {"pronounce": "yo", "letter_parsed_key": "ᅭ", "letter": "ᅭ", "letter_parsed_full": "ᅭ"}, {"pronounce": "u", "letter_parsed_key": "ᅮ", "letter": "ᅮ", "letter_parsed_full": "ᅮ"}, {"pronounce": "wo", "letter_parsed_key": "ᅮᅥ", "letter": "ᅯ", "letter_parsed_full": "ᅮᅥ"}, {"pronounce": "we", "letter_parsed_key": "ᅮᅦ", "letter": "ᅰ", "letter_parsed_full": "ㅜㅓㅣ"}, {"pronounce":"ui", "letter_parsed_key": "ᅮᅵ", "letter": "ᅱ", "letter_parsed_full": "ᅮᅵ"}, {"pronounce": "yu", "letter_parsed_key": "ᅲ", "letter": "ᅲ", "letter_parsed_full": "ᅲ"}, {"pronounce": "eu", "letter_parsed_key": "ᅳ", "letter": "ᅳ", "letter_parsed_full": "ᅳ"}, {"pronounce":"wi", "letter_parsed_key": "ᅳᅵ", "letter": "ᅴ", "letter_parsed_full": "ᅳᅵ"}, {"pronounce": "i", "letter_parsed_key": "ᅵ", "letter": "ᅵ", "letter_parsed_full": "ᅵ"}],
  "final":
    [{"pronounce": "", "letter_parsed": "", "letter": ""}, {"pronounce": "k", "letter_parsed": "ᄀ", "letter": "ㄱ"}, {"pronounce": "kk", "letter_parsed": "ᄀᄀ", "letter": "ㄲ"}, {"pronounce": "ks", "letter_parsed": "ㄱㅅ", "letter": "ㄳ"}, {"pronounce": "n", "letter_parsed": "ᄂ", "letter": "ㄴ"}, {"pronounce": "nj", "letter_parsed": "ㄴㅈ", "letter": "ㄵ"}, {"pronounce": "nh", "letter_parsed": "ㄴㅎ", "letter": "ㄶ"}, {"pronounce": "d", "letter_parsed": "ᄃ", "letter": "ㄷ"}, {"pronounce": "l", "letter_parsed": "ㄹ", "letter": "ㄹ"}, {"pronounce": "lk", "letter_parsed": "ㄹㄱ", "letter": "ㄺ"}, {"pronounce": "lm", "letter_parsed": "ㄹㅁ", "letter": "ㄻ"}, {"pronounce": "lb", "letter_parsed": "ㄹㅂ", "letter": "ㄼ"}, {"pronounce": "ls", "letter_parsed": "ㄹㅅ", "letter": "ㄽ"}, {"pronounce": "lt", "letter_parsed": "ㄹㅌ", "letter": "ㄾ"}, {"pronounce": "lp", "letter_parsed": "ㄹㅍ", "letter": "ㄿ"}, {"pronounce": "lh", "letter_parsed": "ㄹᄒ", "letter": "ㅀ"}, {"pronounce": "m", "letter_parsed": "ᄆ", "letter": "ㅁ"}, {"pronounce": "b", "letter_parsed": "ᄇ", "letter": "ㅂ"}, {"pronounce": "bs", "letter_parsed": "ᄇᄉ", "letter": "ㅄ"}, {"pronounce": "s", "letter_parsed": "ᄉ", "letter": "ㅅ"}, {"pronounce": "ss", "letter_parsed": "ㅅㅅ", "letter": "ㅆ"}, {"pronounce": "ng", "letter_parsed": "ᄋ", "letter": "ㅇ"}, {"pronounce": "j", "letter_parsed": "ᄌ", "letter": "ㅈ"}, {"pronounce": "ch", "letter_parsed": "ᄎ", "letter": "ㅊ"}, {"pronounce": "k", "letter_parsed": "ᄏ", "letter": "ㅋ"}, {"pronounce": "t", "letter_parsed": "ᄐ", "letter": "ㅌ"}, {"pronounce": "p", "letter_parsed": "ᄑ", "letter": "ㅍ"}, {"pronounce": "h", "letter_parsed": "ᄒ", "letter": "ㅎ"}]
}'
hangul_dic = JSON.parse(hangul_dic_json)

def parse_hangul (hangul_char,hangul_dic)
  targetCharCode = hangul_char.unpack('U*').first
  targetCharBaseCode = targetCharCode - 0xac00;
  final_index = targetCharBaseCode % 28;
  medial_index = (targetCharBaseCode / 28).to_i % 21;
  initial_index = (targetCharBaseCode / 28 / 21).to_i;
  {
    :initial=>hangul_dic["initial"][initial_index],
    :medial=>hangul_dic["medial"][medial_index],
    :final=>hangul_dic["final"][final_index]
  }
end

kanji_oldkana_dic = {}
open("data/00_old_kana_kanji.csv") do |f|
  f.each do |line|
    record = line.chomp.split(',')
    kanji_oldkana_dic[record[1]] = record[0]
  end
end

parsed_dic = []

STDIN.each do |line|
  next if line.length == 1
  # parsing
  record = line.chomp.split(',')
  next if record[2] == nil
  kanjis = [record[0]]
  kanas = [record[1]]
  hanguls = [record[2]]
  next unless kanjis.length == kanas.length  #訓読みノイズ除去(例:薔薇)
  kanjis.length.times do |i|
    kana_parsed = kanas[i].split('').join('-').gsub(/-([ャ-ョ])/,'\1')
    kana_parsed_romaji = Romaji.kana2romaji(kana_parsed).sub(/([a,i,u,e,o])/,'-\1').gsub(/ch-/,'t-y').gsub(/ts/,'t').gsub(/sh/,'sy').gsub(/y-/,'-y').gsub(/-yi/,'-i')
    hangul_parsed_obj = parse_hangul(hanguls[i],hangul_dic)
    hangul_parsed_str = hangul_parsed_obj[:initial]["letter"] + hangul_parsed_obj[:medial]["letter"] + hangul_parsed_obj[:final]["letter"]
    hangul_parsed_pronounce = hangul_parsed_obj[:initial]["pronounce"] + '-' + hangul_parsed_obj[:medial]["pronounce"] + '-' + hangul_parsed_obj[:final]["pronounce"]
    oldkana = kanji_oldkana_dic[kanjis[i]]
#      hangul_parsed_pronounce.gsub!(/^-/,'')
#      hangul_parsed_pronounce.gsub!(/-$/,'')
    parsed_dic << [kanjis[i],kanas[i],kana_parsed,kana_parsed_romaji,hanguls[i],hangul_parsed_str,hangul_parsed_pronounce,oldkana]
  end
end

merged_parsed_dic = {}

parsed_dic.each do |record|
  merged_parsed_dic[record[0]+record[1]] = record
end

merged_parsed_dic.each do |key,record|
  puts record.join(',')
end
