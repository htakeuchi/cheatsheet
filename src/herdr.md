---
title: Herdr
category: Devops
tags: [Terminal, AIエージェント, Mac, Ubuntu]
updated: 2026-07-23
columns: 3
description: Herdrのショートカットと使い方
---
## 基本操作

### 起動と再接続

| 操作 | コマンド |
| --- | --- |
| 起動または再接続 | `herdr` |
| detach | `Ctrl+b` → `q` |
| サーバー停止 | `herdr server stop` |

### 最初に覚えるキー

デフォルトのprefixは `Ctrl+b`。

| 操作 | キー |
| --- | --- |
| ヘルプ表示 | `prefix+?` |
| 新しいタブ | `prefix+c` |
| 右に分割 | `prefix+v` |
| 下に分割 | `prefix+minus` |
| ペイン移動 | `prefix+h/j/k/l` |
| ワークスペース切替 | `prefix+w` |
| detach | `prefix+q` |

## ペイン操作

| 操作 | キー |
| --- | --- |
| 左／下／上／右へ移動 | `prefix+h/j/k/l` |
| 次のペイン | `prefix+tab` |
| 前のペイン | `prefix+shift+tab` |
| 左／下／上／右へ入れ替え | `prefix+shift+h/j/k/l` |
| 右に分割 | `prefix+v` |
| 下に分割 | `prefix+minus` |
| ペインを閉じる | `prefix+x` |
| ペインをズーム | `prefix+z` |
| リサイズモード | `prefix+r` |
| ペイン名変更 | `prefix+shift+p` |
| スクロールバックを編集 | `prefix+e` |

## タブ操作

| 操作 | キー |
| --- | --- |
| 新しいタブ | `prefix+c` |
| 次のタブ | `prefix+n` |
| 前のタブ | `prefix+p` |
| 1〜9番目のタブへ移動 | `prefix+1..9` |
| タブ名変更 | `prefix+shift+t` |
| タブを閉じる | `prefix+shift+x` |

| タブ名 | 用途 |
| --- | --- |
| `main` | シェル、エージェント |
| `test` | テスト、ビルド、ログ |
| `server` | 開発サーバー、watch |
| `notes` | 調査メモ、作業ログ |

## ワークスペース操作

| 操作 | キー |
| --- | --- |
| 一覧表示と切替 | `prefix+w` |
| Goto picker | `prefix+g` |
| 新しいワークスペース | `prefix+shift+n` |
| 新しいworktree | `prefix+shift+g` |
| ワークスペース名変更 | `prefix+shift+w` |
| ワークスペースを閉じる | `prefix+shift+d` |
| サイドバー表示切替 | `prefix+b` |

## コピー操作

コピーmodeは `prefix+[` で開始します。

| 操作 | キー |
| --- | --- |
| 移動 | `h/j/k/l` |
| 単語移動 | `w/b/e` |
| 段落やブロック移動 | `{` / `}` |
| 選択開始 | `v` または `Space` |
| コピー | `y` または `Enter` |
| 終了 | `q` または `Esc` |
