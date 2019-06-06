# Cheatsheet

Markdownで書いたチートシートを指定した段数で段組したHTMLへ変換し、自動的にインデクスページを生成する。

出力例は[こちら](https://namaraii.com/cheatsheet/)。

## セットアップ

```
$ bundle install
```

## 使用法

### MarkdownをHTMLへ変換する 

```
$ bundle exec rake
```

src配下のMarkdownからdoc配下へチートシートを生成する。同時にチートシートのインデクスページを更新する。


### Webサーバを起動する

```
$ bundle exec rake server
```
