---
title: Markdown
category: Markup
tags: [Featured]
updated: 2026-06-26
columns: 3
description: CommonMark 0.31.2を中心としたMarkdown構文
---

### 段落と空行

段落は通常のテキスト。空行で別段落にする。

    これは1つ目の段落です。

    これは2つ目の段落です。

行末だけの改行はソフト改行。HTMLでは実装により空白または改行として扱われる。

### 強制改行

行末にバックスラッシュ、または半角スペース2つ以上を置く。

    1行目\
    2行目

スペース2つは見えにくいので、手書きではバックスラッシュのほうが確認しやすい。

### 見出し

`#`を1から6個置き、後ろに空白を入れる。

    # 見出し1
    ## 見出し2
    ### 見出し3
    ###### 見出し6

閉じる`#`も使えるが、なくてもよい。

    ## 見出し ##

### Setext見出し

本文の次の行に`=`または`-`を並べる。レベル1と2だけ。

    見出し1
    ===

    見出し2
    ---

`---`は、前の行との関係で見出しにも区切り線にもなる。迷う場合はATX見出しを使う。

### 強調

    *斜体*
    _斜体_
    **太字**
    __太字__
    ***太字の斜体***

単語の途中では、`_`より`*`のほうが意図が伝わりやすい。

### エスケープ

ASCII句読点の前に`\`を置くと、Markdownの意味を打ち消せる。

    \*強調しない\*
    1\. リストにしない
    \# 見出しにしない

コード、コードブロック、自動リンク、生HTML内では同じようには働かない。

### 引用

行頭に`>`を置く。空行にも`>`を置くと、引用内の段落を保てる。

    > 引用文です。
    >
    > 別の段落です。

ネストは`>>`。

    > 外側
    >> 内側

### 箇条書き

`-`、`+`、`*`を使える。1つのリストでは記号をそろえる。

    - 項目
    - 項目
      - 子項目

リスト項目の続きは、項目本文の開始位置に合わせてインデントする。

    - 項目の1段落目

      項目の2段落目

### 番号付きリスト

数字の後に`.`または`)`を置く。表示上の開始番号は先頭項目の数字が使われる。

    1. 最初
    2. 次
    3. 最後

    5) 5から始まる
    6) 次

本文では番号をすべて`1.`にしてもよいが、印刷物では実番号のほうが読みやすい。

### コードスパン

文中のコードはバッククォートで囲む。

    `printf()`

中身にバッククォートを含める場合は、外側をより長いバッククォート列にする。

    `` `code` と表示 ``

コードスパン内ではMarkdown記法は解釈されない。

### フェンス付きコード

バッククォートまたはチルダを3個以上。開始と終了は同じ記号にする。

    ```ruby
    puts "hello"
    ```

    ~~~
    <strong>そのまま表示</strong>
    ~~~

開始行の後ろには情報文字列を書ける。CommonMarkは言語名の扱いまでは規定しない。

### インデントコード

4スペース以上で始めるとコードブロックになる。

        git status
        git diff

リスト内では、リスト項目の本文位置からさらに4スペース相当が目安。

### 区切り線

`*`、`-`、`_`を3個以上。間に空白を入れてもよい。

    ---
    ***
    _ _ _

前後の文脈でSetext見出しと紛らわしい場合は、空行を入れる。

### リンク

インラインリンク。

    [CommonMark](https://commonmark.org/)
    [仕様](https://spec.commonmark.org/0.31.2/ "CommonMark Spec")

参照リンク。

    [CommonMark][cm]

    [cm]: https://commonmark.org/ "CommonMark"

短縮参照リンク。

    [CommonMark][]

    [CommonMark]: https://commonmark.org/

### 自動リンク

URLまたはメールアドレスを`<`と`>`で囲む。

    <https://commonmark.org/>
    <user@example.com>

裸のURLを自動リンクにする機能はCommonMark本体ではない。必要なら`<...>`で囲む。

### 画像

リンクの前に`!`を付ける。`[]`内は代替テキスト。

    ![ロゴ](logo.png)
    ![ロゴ][logo]

    [logo]: https://commonmark.org/help/images/favicon.png

画像タイトルもリンクと同じように書ける。

    ![ロゴ](logo.png "CommonMark")

### HTML

CommonMarkは生HTMLのブロックとインラインを扱える。

    <div class="note">
    MarkdownではなくHTMLとして扱う
    </div>

    文中の <kbd>Cmd</kbd> も書ける。

出力先がHTMLを無効化・サニタイズすることがあるため、公開先の仕様も確認する。

### 文字参照

HTMLの文字参照と数値文字参照を使える。

    &copy;
    &#169;
    &#xA9;

そのまま記号を書けるなら、読みやすさを優先して直接書く。

### よく使う拡張記法

次はCommonMark本体ではないが、GFM、Markdown Extra、Pandoc、Kramdown、各サービスでよく使われる。実装差があるため、公開先の仕様を確認する。

### 表

GFMなどで使われる。区切り行に`:`を置くと配置を指定できることが多い。

    | 名前 | 説明 | 数量 |
    | :--- | :--- | ---: |
    | りんご | 果物 | 3 |
    | ペン | 文具 | 12 |

CommonMark本体では、この記法は通常の段落として扱われる。

### 脚注

GitHub、Pandoc、Kramdownなどで使われる。脚注本文の表示位置は処理系が決める。

    本文に注釈を付ける[^1]。

    [^1]: ここに脚注を書く。

複数行の脚注は、2行目以降をインデントする方式が多い。

### 打ち消し線

GFMなどで使われる。互換性を考えるなら`~~`で囲む。

    ~~削除した文~~

CommonMark本体では、`~~`は普通の文字として扱われる。

### タスクリスト

GFMなどで使われる。リスト項目の先頭に`[ ]`または`[x]`を書く。

    - [x] 完了
    - [ ] 未完了
      - [ ] 子タスク

HTMLではチェックボックスとして表示されることが多い。編集できるかどうかはサービスによる。

### 見出しID

Pandoc、Kramdown、Markdown Extra系で使われる。任意のアンカーを付けたいときに使う。

    ### インストール {#install}

GitHubは見出しから自動でIDを生成するが、上の`{#install}`形式はそのまま使えない場合がある。

### 定義リスト

Markdown Extra、Pandoc、Kramdownなどで使われる。

    用語
    : 説明文

    別の用語
    : 1つ目の説明
    : 2つ目の説明

HTMLでは`<dl>`、`<dt>`、`<dd>`に変換されることが多い。

### Front Matter

静的サイトジェネレータやドキュメントツールで使われるメタデータ。Markdown本文ではなく、ファイル先頭の設定として扱われる。

    ---
    title: 記事タイトル
    tags:
      - Markdown
    ---

    ここから本文。

YAML形式が多いが、TOMLやJSONを使うツールもある。

### 数式

MathJaxやKaTeXを使う環境で使われる。インラインは`$...$`、別行は`$$...$$`が多い。

    文中の数式は $E = mc^2$ のように書く。

    $$
    a^2 + b^2 = c^2
    $$

通常の文章でドル記号を使う場合、数式として誤解釈されることがある。

### 絵文字ショートコード

GitHubやチャット系サービスなどで使われる。

    :smile:
    :warning:
    :thumbsup:

使える名前はサービスごとに異なる。Unicode絵文字を直接書くほうが移植性が高い場合もある。

### 裸URLの自動リンク

GFMなどでは、`<...>`で囲まないURLもリンクになる。

    https://commonmark.org/
    www.example.com
    user@example.com

CommonMark本体で確実にリンクにしたい場合は`<https://commonmark.org/>`の形にする。

### アラート

GitHubなど一部サービスで使われる注意書き。引用ブロックを拡張した記法。

    > [!NOTE]
    > 補足情報を書く。

    > [!WARNING]
    > 注意が必要な情報を書く。

使える種類や表示デザインはサービスごとに異なる。

### 参考

- [CommonMark Spec 0.31.2](https://spec.commonmark.org/0.31.2/)
- [CommonMark Markdown Reference](https://commonmark.org/help/)
- [GitHub Flavored Markdown Spec](https://github.github.com/gfm/)
- [GitHub Docs: Basic writing and formatting syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
- [PHP Markdown Extra](https://michelf.ca/projects/php-markdown/extra/)
