# Cheatsheet

Markdownで書いたチートシートを指定した段数で段組したHTMLへ変換し、自動的にインデクスページを生成する。

出力例は[こちら](https://cheatsheets.namaraii.com/)

## セットアップ

```
$ bundle install
```

## 使用法

### MarkdownをHTMLとPDFへ変換する

```
$ bundle exec rake
```

src配下のMarkdownからdocs配下へチートシートHTMLとPDFを生成する。同時にチートシートのインデクスページを更新する。


### Webサーバを起動する

```
$ bundle exec rake server

```

### 印刷用PDFを生成する

PDF生成にはNode.jsの依存関係が必要です。

```
$ npm install
```

Chromiumが見つからない場合は、次のコマンドでPlaywright用ブラウザを入れる。

```
$ npx playwright install chromium
```

すべてのチートシートを印刷用HTMLへ変換する。

```
$ bundle exec rake print
```

`bundle exec rake` または `bundle exec rake pdf` ですべてのチートシートをPDFへ変換する。各PDFは用紙1ページに収まるように自動でカラム数と文字サイズを調整する。
PDFが生成済みのチートシートは、HTML上部のGitHubアイコンの右にPDFダウンロードリンクを表示する。

```
$ bundle exec rake pdf
```

1ファイルだけPDF化する。

```
$ bundle exec rake pdf:one SRC=src/flstudio.md
```

用紙や向きを指定する。

```
$ bundle exec rake pdf:one SRC=src/flstudio.md PAPER=A4 ORIENTATION=landscape
$ bundle exec rake pdf:one SRC=src/flstudio.md PAPER=A3 ORIENTATION=portrait COLUMNS=4
```

Markdownのfront matterでもPDF設定を指定できる。

```yaml
pdf:
  paper: A4
  orientation: landscape
  columns: auto
  margin_mm: 3
  min_font_size_pt: 5.5
  max_font_size_pt: 8
```

指定した最小文字サイズで1ページに収まらない場合は、極端に小さいPDFを作らずエラーにする。
