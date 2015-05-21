# joyo-kanji-hanja-analysis

## 概要

文科省策定の常用漢字一覧をコーパスとした日韓漢字読み比較を実装した。
一般的に知られている[日韓の漢字読みの対応](http://colspan.hatenablog.com/entry/2014/11/04/211152)を定量的に明らかにする。

## 分析情報源

| データ | 情報源 |
|:-----------|:------------|
| コーパス | [Wikipedia 常用漢字一覧](http://ja.wikipedia.org/wiki/%E5%B8%B8%E7%94%A8%E6%BC%A2%E5%AD%97%E4%B8%80%E8%A6%A7) |
|ハングル漢字変換|[한글 &lt;-&gt; 한자 코드 변환](http://nlp.kookmin.ac.kr/data/hanja.html)|
|漢字読み旧仮名遣い仮名変換|[歴史的仮名遣い変換辞書「快適仮名遣ひ」](http://www5a.biglobe.ne.jp/~accent/form/henkan.htm)|
|韓国語体(旧字体)日本語体(新字体)変換 |[旧字体・新字体変換](http://www.geocities.jp/qjitai/)|
</table>
</div>

## 依存関係

* Python (パイプライン制御)
   * luigi
* Ruby (解析全般)
   * romaji

## 実行方法

### 解析
```sh
./joyo-jpkr-analysis.py
```
