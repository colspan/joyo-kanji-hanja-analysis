#!/usr/bin/python
# -*- coding: utf-8 -*-

from collections import defaultdict
from luigi import six
import luigi
import subprocess
import sys

class UnixCommandTask(luigi.Task):
  cmdargs = None
  def setCommand(self,cmdargs):
    self.cmdargs = cmdargs
  def run(self):
    proc = subprocess.Popen(self.cmdargs,stdin=self.input().open('r'),stdout=subprocess.PIPE)
    with self.output().open('w') as out_file:
      ret = proc.communicate()[0]
      print >> out_file, ret

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

class P02_AppendFieldKanji2Hangul(UnixCommandTask):
  target = 'work/02_jpkr_kanji_hanja_dic_kanjihangul.csv'
  cmdargs = ['ruby','02_append_field_kanji2hangul.rb']
  def output(self):
    return luigi.LocalTarget(self.target)
  def requires(self):
    return P01_ExtractKanjiKana()

class P03_ParsePronunciation(UnixCommandTask):
  target = 'work/03_jpkr_kanji_hanja_dic_parsed_pronunciation.csv'
  cmdargs = ['ruby','03_parse_pronunciation.rb']
  def output(self):
    return luigi.LocalTarget(self.target)
  def requires(self):
    return P02_AppendFieldKanji2Hangul()

class P04_CleansingAndAppendLabels(UnixCommandTask):
  target = 'work/04_jpkr_kanji_hanja_dic.csv'
  cmdargs = ['ruby','04_cleansing_append_labels.rb']
  def output(self):
    return luigi.LocalTarget(self.target)
  def requires(self):
    return P03_ParsePronunciation()

if __name__ == '__main__':
  luigi.run(main_task_cls=P04_CleansingAndAppendLabels,local_scheduler=True )
