---
title: Scrapbox
category: Wiki
tags: [Featured]
updated: 2018-12-18
columns: 3
description: Wiki
---
### 文字修飾

いわゆるHeadingに該当する記法は無いため、見出しは太字を使って表現する。

| | |
|---|---|
|太字|[太字]|
|太字|[* 太字]|
|もっと太字|[**** 太字]|
|斜体文字|[/ 斜体文字]|
|太字斜体文字|[/* 太字斜体文字]|
|打ち消し線|[- 打ち消し線]|
|斜体太字打ち消し線|[-***/ 打ち消し線]|

### 箇条書き
行頭にスペースかタブを入力する。文字数に応じてインデントが深くなる。

### リンク
| | |
|---|---|
|Scrapboxページへのリンク|[Scrapboxの特長]|
|外部リンク|http://yahoo.co.jp|
|外部リンク|[http://yahoo.co.jp]|
|外部リンク|[http://yahoo.co.jp Yahoo!]|
|外部リンク|[Yahoo! http://yahoo.co.jp]|

### ハッシュタグ記法
`#ハッシュ` と`[ハッシュ]` は同じ意味。

文章の中では`[ハッシュ]`と書き、文書外では `#ハッシュ` と書くとわかりやすい。

### 画像
| | |
|---|---|
|画像の引用|[https://gyazo.com/da78d.png]|
|画像+リンク|[http://yahoo.co.jp https://i.gyazo.com/da78d.png]|
|画像+リンク|[https://i.gyazo.com/da78d.png http://yahoo.co.jp]|

### 引用
行頭に`>`を書くと引用になる。

### テーブル
`table:テーブル名` の後、インデントしてタブ区切りで行を書く。

    table:テーブルの例
      abc	def
      12345	6789
      すごく長い文字列	短い文字列

### コード（インライン）
バッククオートで括る。

    `function() {  return true }`

### コードブロック
`code:言語名`もしくは`code:ファイル名`もしくは`code:ファイル名(言語名)`の下のブロックがシンタックスハイライトされる。

```javascript
    code:hello.js
      function () {
        alert(document.location.href)
        console.log("hello")
      }
```

### アイコン
| | |
|---|---|
|アイコン|[rakusai.icon]|
|アイコン|[/icons/炎上.icon]|

### 数式
    [$ \frac{-b \pm \sqrt{b^2-4ac}}{2a}]