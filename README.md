# rails-react-on-docker
DockerでRails+mysqlの環境を構築し、webpacker(gem)でReactを導入する.

## 開発環境構築
- このリポジトリをクローンする
```
git clone git@github.com:mt-st1/rails-react-on-docker.git
```
- プロジェクトの構築
  - `docker-compose build`コマンドでサービスのビルドを実行する
  - webpacker及びreact関連モジュールのインストール
  ```
  docker-compose run web rails webpacker:install
  docker-compose run web rails webpacker:install:react
  ```
  - アプリケーションを起動する  
  railsサーバーとmysqlサーバーを同時に起動してくれる
  ```
  docker-compose up
  ```
  - データベースを作成する
  ```
  docker-compose run app rake db:create
  ```

ブラウザで`http://localhost:3000`にアクセスして確認.

※ Gemfileが更新されたときは`docker-compose build`でビルドし直す必要がある

## 開発で使いそうなコマンド

[docker-composeでよく使いそうなコマンド](http://kasei-san.hatenablog.com/entry/2018/03/12/060801)  

[docker-composeコマンドまとめ](https://qiita.com/aild_arch_bfmv/items/d47caf37b79e855af95f)

### サーバー停止
`docker-compose up`により起動したサーバーを停止するときは  
```
docker-compose down
```
より行う.  
`Ctrl+c`で終了すると`tmp/pids/server.pid`が残り次回起動するために手動で削除することになるため注意.  

### Dockerfileやdocker-compose.ymlの変更を反映させたり, railsサーバーを再起動させる
```
docker-compose up --build
```

### `bundle install`などコマンド実行
```
docker-compose run app bundle install
```
`docker-compose run {サービス名} {任意のコマンド}`で実行できる.

### ローカルターミナルからmysqlコンソールで接続
```
mysql -uroot -p -h0.0.0.0 -P3306
```
ホスト名が`localhost`では接続できないため注意.

### コンテナに接続して中身をみたいとき
`docker ps`で実行中のコンテナIDを確認
```
❯❯❯ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
e423d9e7a07b        date-adjuster_app   "bundle exec rails s…"   41 minutes ago      Up 41 minutes       0.0.0.0:3000->3000/tcp              date-adjuster_app_1
f2a1c1e5f364        mysql:5.7           "docker-entrypoint.s…"   41 minutes ago      Up 41 minutes       0.0.0.0:3306->3306/tcp, 33060/tcp   date-adjuster_mysql_1
```
  
```
docker exec -it {コンテナID} /bin/bash
```
