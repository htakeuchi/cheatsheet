---
title: Herdr
category: Devops
tags: [Terminal, AIエージェント, Mac, Ubuntu]
updated: 2026-07-23
columns: 4
description: Herdrのショートカットと使い方
---

Herdrは、Claude Code、Codex、opencodeなどのAIエージェントを複数のペイン、タブ、ワークスペースで動かすterminal multiplexerです。

## 基本操作

### 起動と再接続

| 操作 | コマンド |
| --- | --- |
| 起動または再接続 | `herdr` |
| detach | `Ctrl+b` → `q` |
| サーバー停止 | `herdr server stop` |

`Ctrl+b` → `q` はクライアントをdetachするだけなので、ペイン内のエージェントやコマンドは動き続けます。

### Prefixの押し方

デフォルトのprefixは `Ctrl+b` です。
`prefix+c` のような表記は同時押しではなく、`Ctrl+b`を押して離してから `c`を押します。

現在有効なキーの一覧は `Ctrl+b` → `?` で表示できます。

### 最初に覚えるキー

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

エージェントを1つずつペインに置き、隣に `git diff`、テスト、ログ監視を置くと作業状況を確認しやすくなります。
`prefix+z` は現在のペインを一時的に最大化し、同じキーで元に戻します。

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

サイドバーは複数のリポジトリやエージェントの状態（working、blocked、done）を確認するダッシュボードとして使えます。

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

マウスでドラッグ選択する場合は、コピーmodeに入らずに操作できます。

## MacとUbuntuの注意点

| 項目 | 内容 |
| --- | --- |
| prefix | どちらも `Ctrl+b`。Macでも `Cmd`ではない |
| 直接キー | `Ctrl+Alt`系は候補になるが、OS側との衝突を確認する |
| MacのOption | 特殊文字入力になる場合があるため、terminal側で確認する |

Ubuntuでは次のキーがOS側と衝突しやすいため、直接ショートカットには割り当てません。

| キー | 衝突先の例 |
| --- | --- |
| `Ctrl+Alt+T` | 端末起動 |
| `Ctrl+Alt+矢印` | GNOMEのワークスペース切替、terminal |
| `Ctrl+Alt+F1..F12` | Linux仮想コンソール |
| `Ctrl+Alt+L` | ロック画面 |

Herdrのmouse captureを無効にすると、ホストterminalのクリック処理を優先できます。

```toml
[ui]
mouse_capture = false
```

mouse captureを有効にしたままterminal側でクリックする場合は、Linuxでは `Shift+Ctrl+click`、macOSでは `Shift+Cmd+click`を使います。

## 設定

設定ファイルは `~/.config/herdr/config.toml` です。

```bash
mkdir -p ~/.config/herdr
herdr --default-config > ~/.config/herdr/config.toml
herdr server reload-config
```

### 直接ショートカットの追加

prefix操作を残したまま、よく使う移動だけ直接キーにも割り当てられます。

```toml
[keys]
prefix = "ctrl+b"
focus_pane_left = ["prefix+h", "ctrl+alt+h"]
focus_pane_down = ["prefix+j", "ctrl+alt+j"]
focus_pane_up = ["prefix+k", "ctrl+alt+k"]
focus_pane_right = ["prefix+l", "ctrl+alt+shift+l"]
next_tab = ["prefix+n", "ctrl+alt+]"]
previous_tab = ["prefix+p", "ctrl+alt+["]
new_tab = ["prefix+c", "ctrl+alt+c"]
zoom = ["prefix+z", "ctrl+alt+z"]

[ui]
agent_panel_sort = "priority"
show_agent_labels_on_pane_borders = true
```

`Ctrl+Alt+L` はロック画面などと衝突する場合があるため、右移動には `Shift`を加えています。

### 通知

```toml
[ui.toast]
delivery = "terminal"
delay_seconds = 1

[ui.sound]
enabled = true
```

toastの配送先は `off`、`herdr`、`terminal`、`system`から選べます。
macOSでは `terminal-notifier` または `osascript`、Linuxでは `notify-send`が使われます。
Linuxで通知を表示するには `DISPLAY` または `WAYLAND_DISPLAY`が必要です。

## リモート利用

### SSH先で起動する

```bash
ssh user@server
herdr
```

サーバー側のHerdr serverにペインが残るため、detach後に再接続できます。

### ローカルからremote clientとして接続する

```bash
herdr --remote workbox
herdr --remote ssh://user@server:2222
```

```sshconfig
Host workbox
  HostName server.example.com
  User user
  Port 2222
```

## CLIからペインを操作する

```bash
herdr pane list
herdr pane current
herdr pane read <pane_id> --source recent-unwrapped --lines 120
herdr pane run <pane_id> "npm test"
herdr pane send-text <pane_id> "hello"
herdr pane send-keys <pane_id> enter
```

コマンドを実行する場合は、テキスト送信とEnterを分けるより `pane run`を使うほうが安全です。

## MacとUbuntuの使い分け

| 環境 | 用途 |
| --- | --- |
| Mac | 開発リポジトリごとにHerdrを起動し、Claude Code、Codex、opencodeをタブやペインで分ける |
| Ubuntu | 長時間ビルド、サーバー常駐、重い検証を動かす |
| MacからUbuntu | `herdr --remote ubuntu-box`でUbuntu側の作業を操作する |

Macでのペイン構成は、左にAIエージェント、右上に `git status`や `git diff`、右下にテストや開発サーバーを置くと扱いやすくなります。

## 練習メニュー

1. `herdr`で起動する
2. `prefix+c`でタブを作る
3. `prefix+v`で右に分割する
4. `prefix+minus`で下に分割する
5. `prefix+h/j/k/l`で移動する
6. `prefix+z`でズームする
7. `prefix+q`でdetachする
8. `herdr`で再接続する

## 参考

- [Herdr公式サイト](https://herdr.dev/)
- [Herdr GitHub](https://github.com/ogulcancelik/herdr)
- [Keyboard](https://herdr.dev/docs/keyboard/)
- [Configuration](https://herdr.dev/docs/configuration/)
- [How to work with Herdr](https://herdr.dev/docs/how-to-work/)
- [CLI reference](https://herdr.dev/docs/cli-reference/)
