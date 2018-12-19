---
title: Docker
category: Devops
tags: 
updated: 2018-12-19
columns: 2
description: よく使うDockerコマンドのまとめ
---

* データベースなど永続化したいデータはホストOS上に作成してマウントした方が良い
* コンテナ内で作業するためにsshdをインストールしない

### コンテナの実行

```
$ docker run —name=“コンテナ名” イメージ名 
```

バックグラウンド実行/ホストの80番ポートのパケットをコンテナの80番ポートへ転送/httpdのタグ2.2.31を取得 

```
$ docker run -d -p 8080:80 httpd:2.2.31 
```

### 稼働中コンテナの状態を表示 

```
$ docker ps -a 
```

### 停止中コンテナの再実行 

```
$ docker start -a コンテナ名 
```

### コンテナの削除 

```
$ docker rm コンテナ名 
```

### ローカル環境のイメージ一覧を表示する 

```
$ docker images 
```

### イメージの削除 

```
$ docker rmi イメージ名 
```

### Docker HUBを検索する 

```
$ docker search 検索文字列  
```

### カスタマイズしたコンテナからイメージを作成

```
$ docker commit -c “EXPOSE 22” -c “CMD /usr/sbin/sshd -D” static_pare htakeuchi/sshd
```
* TCP22番ポートをlisten
* コンテナ起動時にsshdをバックグラウンドで起動
* static_pare: コンテナ名
* htakeuchi/sshd: カスタムイメージ名

### ローカルにあるイメージを強制的に削除

```
$ docker rmi -f $(docker images -aq)
```

### イメージにリポジトリ名やタグ名を付与する

```
$ docker tag ubuntu:14.04 htakeuchi/ubuntu:14.04
```

ローカルイメージubuntu:14.04をhtakeuchi/ubuntu:14.04に変更する

### イメージやコンテナの詳細情報を表示する

```
$ docker inspect コンテナまたはイメージ
$ docker inspect -f  ‘{{{ . Config.Hostname }}}’ ubuntu:14.04
```

### イメージの作成履歴を表示する

```
$ docker history イメージ
```

### Dockerfileからイメージを作成する

```
$ docker build ディレクトリまたはURL
$ docker build -t myimage:v1.0 /home/htakeuchi/newimage
$ docker buiild -t myimage:v1.0 git://example.com/sample.git
$ docker buiild -t myimage:v1.0 git://example.com/sample.git#newbranch:docker
```

### イメージをtarアーカイブ形式で保存する

```
$ docker save -o ubuntu-all.tar イメージ
$ docker save ubuntu:14.04 | gzip > ubuntu-14.04.tar.gz
```

### tarアーカイブからイメージを復元する

```
$ docker load -i ubuntu-14.04.tar.gz
```

### ファイルシステムデータからイメージを作成する

```
$ tar -c home/newimage | docker import - newimage:v1.0
$ docker import -c “CMD /bin/bash” sample.tar.gz newimage:v1.0
$ docker import -m “Imported from tarball” sample.tar.gz newimage:v1.0
```

### コンテナとクライアント環境の間でファイルをコピーする

```
$ docker cp コンテナ:パス クライアント環境のパス
$ docker cp クライアント環境のパス コンテナ:パス 
```

コンテナはコンテナ名かコンテナIDを指定する。

### DockerHubへの公開

```
$ docker login
$ docker build -t username/sample-image:latest .
$ docker push username/sample-image
```

### ロケールの設定

デフォルトのロケールはPOSIXになっているので、Dockerファイルへ以下を書く。

```
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
```

### Webサーバを起動する

```
$ ruby -rwebrick -e 'WEBrick::HTTPServer.new(:DocumentRoot => "./", :Port => 8000).start'
$ ruby​​ -run -e httpd -p 8000
```

### 参考サイト

* [docker-compose による nginx + HTTPruby /2 + PHP-FPM7 + MySQL 環境の構築方法 – PSYENCE:MEDIA](https://goo.gl/KV9Dt3)
* [Middleman で作った web サイトを Travis + GitHub pages でお手軽に運用する - tricknotesのぼうけんのしょ](https://goo.gl/Ahh7D)
