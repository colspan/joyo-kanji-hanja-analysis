#!/usr/bin/python
# -*- coding: utf-8 -*-

from collections import defaultdict
from luigi import six
import luigi
import subprocess
import sys

class JoyoJP(luigi.ExternalTask):
  def output(self):
    return luigi.LocalTarget('data/joyo.csv')

class P01_ExtractKanjiKana(luigi.Task):
  def output(self):
    return luigi.LocalTarget('work/01_joyo_kanji_kana.csv')

  def requires(self):
    return JoyoJP()

  def run(self):
    with self.input().open('r') as in_file:
      with self.output().open('w') as out_file:
        skip_line = True
        for line in in_file:
          if skip_line: #1行目はスキップ
            skip_line = False
            continue
          try:
            record = line.strip().split(',')
            if len(record) < 9 or record[8] == '':
              continue
            print >> out_file, record[1] + ',' +  record[8]
          except ValueError, e:
            continue

class P02_AppendFieldKanji2Hangul(luigi.Task):
  target = 'work/02_jpkr_kanji_hanja_dic_kanjihangul.csv'
  def output(self):
    return luigi.LocalTarget(self.target)
  def requires(self):
    return P01_ExtractKanjiKana()
  def run(self):
    proc = subprocess.Popen(['ruby','02_append_field_kanji2hangul.rb'],stdin=self.input().open('r'),stdout=subprocess.PIPE)
    with self.output().open('w') as out_file:
      ret = proc.communicate()[0]
      print >> out_file, ret

class P03_ParsePronunciation(luigi.Task):
  target = 'work/03_jpkr_kanji_hanja_dic_parsed_pronunciation.csv'
  def output(self):
    return luigi.LocalTarget(self.target)
  def requires(self):
    return P02_AppendFieldKanji2Hangul()
  def run(self):
    proc = subprocess.Popen(['ruby','03_parse_pronunciation.rb'],stdin=self.input().open('r'),stdout=subprocess.PIPE)
    with self.output().open('w') as out_file:
      ret = proc.communicate()[0]
      print >> out_file, ret

class P04_CleansingAndAppendLabels(luigi.Task):
  target = 'work/04_jpkr_kanji_hanja_dic.csv'
  def output(self):
    return luigi.LocalTarget(self.target)
  def requires(self):
    return P03_ParsePronunciation()
  def run(self):
    proc = subprocess.Popen(['ruby','04_cleansing_append_labels.rb'],stdin=self.input().open('r'),stdout=subprocess.PIPE)
    with self.output().open('w') as out_file:
      ret = proc.communicate()[0]
      print >> out_file, ret

if __name__ == '__main__':
  luigi.run(main_task_cls=P04_CleansingAndAppendLabels,local_scheduler=True )
