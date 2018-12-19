---
title: bl.ocks.org
category: Devops
tags: 
updated: 2018-12-19
columns: 2
description: bl.ocks.orgでD3.jsのグラフを公開する
---

### Gistを作成する

* index.html
* .block (ライセンス）
* README.md

### bl.ocks.orgへアクセスする

https://bl.ocks.org/htakeuchi

### Gistをcloneする

```bash
cd /Users/hitoshi/project/raw
git clone https://gist.github.com/a60c0ecb55713c06c054c26c6dbed57a.git
```

### サムネイルを作成する

```bash
webkit2png -W 960 -H 500 -F -o thumbnail https://bl.ocks.org/htakeuchi/raw/a60c0ecb55713c06c054c26c6dbed57a/ 
mogrify -resize 230x120 thumbnail-full.png
mv thumbnail-full.png thumbnail.png 
git add thumbnail.png 
git commit -am "add thumnail"
git push
```

### Webページのスクリーンショットを作成するためのコマンドをインストールしておく

```bash
brew install webkit2png
brew install imagemagick 
```
