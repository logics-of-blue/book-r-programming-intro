
# 条件分岐と繰り返し|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# ifとelseによる条件分岐 ----------------------------------------------------------

## if構文の基本

# 所持金
my_money <- 8000

# 所持金の額によって、表示させる文章を変える
if (my_money < 10000) {
  print("所持金は1万円未満です")
} else if (my_money >= 10000 && my_money < 20000) {
  print("所持金は1万円以上、2万円未満です")
} else {
  print("所持金は2万円以上です")
}


## 条件を変えて実行(2つ目の条件式に合致した場合)

# 所持金が多くなった
my_money <- 18000

# 所持金の額によって、表示させる文章を変える
if (my_money < 10000) {
  print("所持金は1万円未満です")
} else if (my_money >= 10000 && my_money < 20000) {
  print("所持金は1万円以上、2万円未満です")
} else {
  print("所持金は2万円以上です")
}


## 条件を変えて実行(どの条件式にも合致しなかった場合)

# 所持金がもっと多くなった
my_money <- 50000

# 所持金の額によって、表示させる文章を変える
if (my_money < 10000) {
  print("所持金は1万円未満です")
} else if (my_money >= 10000 && my_money < 20000) {
  print("所持金は1万円以上、2万円未満です")
} else {
  print("所持金は2万円以上です")
}


## 中カッコの省略

# 1行で終わるならば、中カッコは不要
x <- 10
if(x > 0) "0より大きい" else "0以下"


# ifelseによる条件分岐 -----------------------------------------------------------

## ifelse関数の基本

# ifelseによる条件分岐の例
my_result <- "OK"
ifelse(my_result == "OK", "問題ない", "大変だ！")

# ifelseによる条件分岐の例
my_result <- "NG"
ifelse(my_result == "OK", "問題ない", "大変だ！")


## ベクトルを引数にして実行

# 絶対値を計算する
my_number <- c(20, -3, -15, 8)
ifelse(my_number < 0, my_number * -1, my_number)

# 参考
abs(my_number)


# memo：andとorの指定の方法
our_money <- c(50000, 18000, 8000)
# 最初の1つの要素しか評価されない
ifelse(our_money >= 10000 && our_money < 20000, 
       "1万円以上2万円未満",
       "それ以外")
# すべての要素を評価する
ifelse(our_money >= 10000 & our_money < 20000, 
       "1万円以上2万円未満",
       "それ以外")


# switchによる条件分岐 -----------------------------------------------------------

## switch関数の基本

# switchによる条件分岐
pattern <- "A"

switch (
  pattern,
  "A" = print("パターンAの処理を実行します"),
  "B" = print("パターンBの処理を実行します"),
  "C" = print("パターンCの処理を実行します"),
  print("その他の処理を実行します")
)


## 条件を変えて実行

# patternを変えて実行
pattern <- "Z"

switch (
  pattern,
  "A" = print("パターンAの処理を実行します"),
  "B" = print("パターンBの処理を実行します"),
  "C" = print("パターンCの処理を実行します"),
  print("その他の処理を実行します")
)


## 条件を数値にして実行

# 条件を数値にして実行
pattern <- 2

switch (
  pattern,
  "A" = print("パターンAの処理を実行します"),
  "B" = print("パターンBの処理を実行します"),
  "C" = print("パターンCの処理を実行します"),
  print("その他の処理を実行します")
)


# forによる繰り返し処理 ------------------------------------------------------------

## forループの基本

# 基本のforループ
for (i in 1:3){
  print(i)
}


## インデックスの変化のさせ方

# iの値は自由に指定できる
for (i in c(5, 10, 23)){
  print(i)
}

# 添え字はiでなくてもよい
for (index in c(5, 10, 23)){
  print(index)
}


## まったく同じ処理を何度も繰り返す

# 同じ処理の繰り返し
for (i in 1:3) {
  print("hello")
}


## forループによるベクトルの操作

# 添え字を変えて実行
input <- c(5, 8, 9)
output <- c(0, 0, 0)
for (i in 1:length(input)) {
  output[i] <- input[i] * 10
}
output

# forループは不要
output_2 <- input * 10
output_2


# whileによる繰り返し処理 ----------------------------------------------------------------

## whileループの基本

# 基本のwhileループ
# カウンター
count <- 3
# ループ
while (count > 0) {
  print(count)
  count <- count - 1
}


## whileループの応用例

# 値が下落するまで続ける
prices <- c(100, 120, 110, 130, 150)

index <- 1
diff <- 0
while (diff >= 0) {
  diff <- prices[index + 1] - prices[index]
  index <- index + 1
}

index

# コードの解読

# 初期条件
index <- 1
diff <- 0

# 初回実行時
diff <- prices[index + 1] - prices[index]
index <- index + 1
diff
index

# diffが正の値なので2回目実行
diff <- prices[index + 1] - prices[index]
index <- index + 1
diff
index

# diffが負の値なので、ここで終了


# breakによる繰り返しの終了 ---------------------------------------------------------

# breakを使うwhileのパターン
input <- c(10, 25, 12)
index <- 1

while (TRUE) {
  # indexがinputの範囲を超える場合ループを抜ける
  if (index > length(input)) break()
  print(input[index]) # inputのindex番目の要素を表示
  index <- index + 1  # indexを1追加
}


# memo：repeatによる繰り返し
input <- c(10, 25, 12)
index <- 1
repeat {
  # indexがinputの範囲を超える場合ループを抜ける
  if (index > length(input)) break()
  print(input[index]) # inputのindex番目の要素を表示
  index <- index + 1  # indexを1追加
}


# nextによる処理のスキップ ---------------------------------------------------------

# nextによる処理のスキップ
for(i in 1:5){
  if(i == 3) next()
  print(i)
}


