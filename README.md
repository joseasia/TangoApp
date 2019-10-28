# TangoApp
## これは何？
僕のはじめてのオリジナルアプリです。2019年8月末からTechAcademyで勉強をはじめ、10月末でカリキュラムが終了。
オリジナルアプリの制作が間に合わず、せこせこと作っている次第。

## 何を作りたいか？
「外国語の単語」を覚える必要がある方（自分をふくむ）のために、シンプルで使い勝手がよく、飽きが来づらく、記憶に残りやすい、そんな初心者にありがちな理想をかかげたAPPを目指す。

## 単語を覚えるために必要なこととは？（最低限の要件定義）
単語を効率よく覚えるためには、単語が「記憶に定着するためのイメージ」と、単語を「どのように利用できるかの活用例」、そして音読するための「発音表記」が必要！（じゃないかと思う）

ということで、最低限の要件として以下の要素が登録できるテーブルを想定

・単語
・意味
・発音
・例文
・画像

## インターフェースはこんな感じを想定（10月末現在の姿）

<img width="392" alt="dd9d283a5b3797406f832101e0b5b53c" src="https://user-images.githubusercontent.com/8777862/67684299-3e985900-f9d6-11e9-9042-b68cdf72627b.png">
※実際には、覚えたい単語をGoogle画像検索にかけ（ここは利用する方が人力で...）、そこに出てくる画像を登録することを想定。

## 現在の躓きリスト（10月末現在）
・画像をrealmに読み込ませるのにbase64の形式にし、それをtableviewで変換をかけて表示させているためロードが長い。
・ライブラリSwipeCellKitを導入したが、cellスワイプ時の操作機能をまだ実装できず持て余してる

## 今後のNice to have 機能（10月末現在）
・投稿をおこなったら「単語と例文は音読しましょう」と表示されるSDKを出す（やっぱり単語を覚えるには音読が大事なので）
・品詞を登録できるようにし、画面上部に品詞ごとのタブを表示し、切り替えられるようにする
・記憶の定着のために、1.4.7.11.15...日といったリズムでリマインダー登録できるようにする
・テスト機能をつける
