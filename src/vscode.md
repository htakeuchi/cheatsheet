---
title: Visual Studio Code
category: Editor
tags: 
updated: 2018-12-20
columns: 3
description: Visual Studio Code
---
MacOS用のキーボードショートカットです。


### 一般

|||
|---|---|
|⇧⌘P, F1|コマンドパレットの表示|
|⌘P|クイックオープン|
|⇧⌘N|新規ウィンドゥ|
|⌘W|ウィンドゥを閉じる|
|⌘,|ユーザ設定|
|⌘K⌘S|キーボードショートカット|

### 編集(基本)

|||
|---|---|
|⌘X|行の削除|
|⌘C|行のコピー|
|⌥↓ / ⌥↑|行の移動|
|⇧⌥↓ / ⇧⌥↑|行をコピー|
|⇧⌘K|行の削除|
|⌘Enter / ⇧⌘Enter|空行の挿入|
|⇧⌘\|対応するブラケットへ飛ぶ|
|⌘] / ⌘[|行のインデント/行のインデント解除|
|Home / End|行の先頭へ/行の末尾へ|
|⌘↑ / ⌘↓|Go to beginning/end of file|
|⌃PgUp / ⌃PgDn|Scroll line up/down|
|⌘PgUp /⌘PgDn|Scroll page up/down|
|⌥⌘[ / ⌥⌘]|Fold/unfold region|
|⌘K ⌘[ / ⌘K ⌘]|Fold/unfold all subregions|
|⌘K ⌘0 / ⌘K ⌘J|Fold/unfold all regions|
|⌘K ⌘C|Add line comment|
|⌘K ⌘U|Remove line comment|
|⌘/|Toggle line comment|
|⇧⌥A|Toggle block comment|
|⌥Z|Toggle word wrap|

### マルチカーソルと選択

|||
|---|---|
|⌥ + click|Insert cursor|
|⌥⌘↑|Insert cursor above|
|⌥⌘↓|Insert cursor below|
|⌘U|Undo last cursor operation|
|⇧⌥I|Insert cursor at end of each line selected|
|⌘I|Select current line|
|⇧⌘L|Select all occurrences of current selection|
|⌘F2|Select all occurrences of current word|
|⌃⇧⌘→ / ←|Expand / shrink selection|
|⇧⌥ + drag mouse|Column (box) selection|
|⇧⌥⌘↑ / ↓|Column (box) selection up/down|
|⇧⌥⌘← / →|Column (box) selection left/right|
|⇧⌥⌘PgUp|Column (box) selection page up|
|⇧⌥⌘PgDn|Column (box) selection page down|

### 検索と置換

|||
|---|---|
|⌘F|Find|
|⌥⌘F|Replace|
|⌘G / ⇧⌘G|Find next/previous|
|⌥Enter|Select all occurrences of Find match|
|⌘D|Add selection to next Find match|
|⌘K ⌘D|Move last selection to next Find match|

### Rich languages editing

|||
|---|---|
|⌃Space|Trigger suggestion|
|⇧⌘Space|Trigger parameter hints|
|⇧⌥F|Format document|
|⌘K ⌘F|Format selection|
|F12|Go to Definition|
|⌥F12|Peek Definition|
|⌘K F12|Open Definition to the side|
|⌘.|Quick Fix|
|⇧F12|Show References|
|F2|Rename Symbol|
|⌘K ⌘X|Trim trailing whitespace|
|⌘K M|Change file language|

### ナビゲーション

|||
|---|---|
|⌘T|Show all Symbols|
|⌃G|Go to Line...|
|⌘P|Go to File...|
|⇧⌘O|Go to Symbol...|
|⇧⌘M|Show Problems panel|
|F8 / ⇧F8|Go to next/previous error or warning|
|⌃⇧Tab|Navigate editor group history|
|⌃- / ⌃⇧-|Go back/forward|
|⌃⇧M|Toggle Tab moves focus|

### エディタ操作

|||
|---|---|
|⌘W|Close editor|
|⌘K F|Close folder|
|⌘\|Split editor|
|⌘1 / ⌘2 / ⌘3|Focus into 1st, 2nd, 3rd editor group|
|⌘K ⌘← / ⌘K ⌘→|Focus into previous/next editor group|
|⌘K ⇧⌘← / ⌘K ⇧⌘→|Move editor left/right|
|⌘K ← / ⌘K →|Move active editor group|

### ファイル管理

|||
|---|---|
|⌘N|New File|
|⌘O|Open File...|
|⌘S|Save|
|⇧⌘S|Save As...|
|⌥⌘S|Save All|
|⌘W|Close|
|⌘K ⌘W|Close All|
|⇧⌘T|Reopen closed editor|
|⌘K|Enter Keep preview mode editor open|
|⌃Tab / ⌃⇧Tab|Open next / previous|
|⌘K P|Copy path of active file|
|⌘K R|Reveal active file in Explorer|
|⌘K O|Show active file in new window/instance|

### 表示

|||
|---|---|
|⌃⌘F|Toggle full screen|
|⌥⌘0|Toggle editor layout (horizontal/vertical)|
|⌘= / ⇧⌘-|Zoom in/out|
|⌘B|Toggle Sidebar visibility|
|⇧⌘E|Show Explorer / Toggle focus|
|⇧⌘F|Show Search|
|⌃⇧G|Show Source Control|
|⇧⌘D|Show Debug|
|⇧⌘X|Show Extensions|
|⇧⌘H|Replace in files|
|⇧⌘J|Toggle Search details|
|⇧⌘U|Show Output panel|
|⇧⌘V|Open Markdown preview|
|⌘K V|Open Markdown preview to the side|
|⌘K Z|Zen Mode (Esc Esc to exit)|

### デバッグ

|||
|---|---|
|F9|Toggle breakpoint|
|F5|Start/Continue|
|F11 / ⇧F11|Step into/ out|
|F10|Step over|
|⇧F5|Stop|
|⌘K ⌘I|Show hover|

### ターミナル統合

|||
|---|---|
|⌃`|Show integrated terminal|
|⌃⇧`|Create new terminal|
|⌘C|Copy selection|
|⌘↑ / ↓|Scroll up/down|
|PgUp / PgDn|Scroll page up/down|

### 出典

https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf
