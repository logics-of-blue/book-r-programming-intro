
# 関数の作成と関数の活用|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# 関数の作成の基本 ----------------------------------------------------------------

# 関数の作成の基本
int_division <- function(x, y) {
  x %/% y
}

# 作成した関数の実行例
int_division(6, 2)
int_division(7, 2)


# memo：returnを使う方法
int_division_return <- function(x, y) {
  return(x %/% y)
}
int_division_return(7, 2)


# memo：中カッコを使わない方法
int_division_simple <- function(x, y) x %/% y
int_division_simple(7, 2)


# memo：関数の上書きに注意
# mean関数を足し算に変更する
mean <- function(data) sum(data)
# mean関数を実行すると、足し算が行われる
mean(1:3)
# オブジェクトの削除
rm(mean)
# もとに戻る
mean(1:3)


# 出力の形式を工夫する -------------------------------------------------------------

## 複数の結果をまとめて出力する

# 2つの結果をまとめて出力
int_division_2 <- function(x, y) {
  quotient <- x %/% y  # 商
  remainder <- x %% y  # 余り
  
  # 結果をlistにまとめて出力
  list(quotient = quotient, remainder = remainder)
}

# 作成した関数の実行例
int_division_2(6, 2)
int_division_2(7, 2)


## invisible関数を用いた結果の隠蔽

# 計算結果を整形してコンソールに出力
int_division_3 <- function(x, y) {
  quotient <- x %/% y  # 商
  remainder <- x %% y  # 余り
  
  # 割り算の計算結果をコンソールに出力
  print(
    sprintf(
      "%s ÷ %s の結果は、商が%sで余りが%sです", 
      x, y, quotient, remainder
    )
  )
  
  # 結果のlistはコンソールに出力させない
  invisible(list(quotient = quotient, remainder = remainder))
}

# 作成した関数の実行例
int_division_3(6, 2)
int_division_3(7, 2)

# 関数を丸カッコで囲う
(int_division_3(7, 2))
# 結果のリストを格納
result <- int_division_3(7, 2)
result


# デフォルト引数 -----------------------------------------------------------------

# デフォルト引数を活用
int_division_4 <- function(x, y, trace = TRUE) {
  quotient <- x %/% y  # 商
  remainder <- x %% y  # 余り
  
  # trace = TRUEのときのみ、
  # 割り算の計算結果をコンソールに出力
  if (trace) {
    print(
      sprintf(
        "%s ÷ %s の結果は、商が%sで余りが%sです", 
        x, y, quotient, remainder
      )
    )
  }

  # 結果のlistはコンソールに出力させない
  invisible(list(quotient = quotient, remainder = remainder))
}

# 作成した関数の実行例
result_1 <- int_division_4(7, 2)
result_2 <- int_division_4(7, 2, trace = FALSE)
result_3 <- int_division_4(7, 2, trace = TRUE)
result_1
result_2
result_3

# 参考
?log


# エラーとワーニングの出力 ------------------------------------------------------------

# 引数のチェック処理を追加
int_division_5 <- function(x, y, trace = TRUE) {
  # メッセージ
  message("■処理が開始されました■")
  
  if (x <= y) {
    # エラーを出力して処理を終了
    stop("「割る数」よりも大きな「割られる数」を指定してください！")
  }
  
  if (y == 0) {
    # ワーニングを出力して処理を続行
    warning("割る数が0なので、商はInfになります")
  }
  
  quotient <- x %/% y  # 商
  remainder <- x %% y  # 余り
  
  # trace = TRUEのときのみ、
  # 割り算の計算結果をコンソールに出力
  if (trace) {
    print(
      sprintf(
        "%s ÷ %s の結果は、商が%sで余りが%sです", 
        x, y, quotient, remainder
      )
    )
  }
  
  # 結果のlistはコンソールに出力させない
  invisible(list(quotient = quotient, remainder = remainder))
}

# 作成した関数の実行例
int_division_5(x = 7, y = 3)
int_division_5(x = 7, y = 8)
int_division_5(x = 7, y = 0)


# 例外処理 ---------------------------------------------------------------

## 繰り返し処理においてエラーが発生した場合

# 計算の対象となるベクトル
a <- c(7, 7, 7, 7)
b <- c(3, 0, 8, 4)

# エラーが出ると、処理が終了される
for (i in 1:length(a)) {
  int_division_5(a[i],　b[i])
}


## try関数を使ったエラーへの対処

# 最後まで処理が繰り返される
for (i in 1:length(a)) {
  try(int_division_5(a[i], b[i]))
}


## tryCatchを使ったエラーへの対処

# エラーが出たときの処理を追加
for (i in 1:length(a)) {
  tryCatch(
    expr = {                    # エラーが出るかもしれない処理
      int_division_5(a[i], b[i])    
    },
    error = function(e) {       # エラーが出たときの処理
      message("以下の問題が発生しました")
      message(e)
      message("\n次の処理を続行します")
    },
    warning = function(w) {     # ワーニングが出たときの処理
      message("以下のワーニングが発生しました")
      message(w)
      message("\n次の処理を続行します")
    },
    finally = {                 # 常に実行される処理
      message("処理が終了されました")
    }
  )
}


# 関数のスコープ -----------------------------------------------------------------

## 関数のスコープの基本

# 関数の中でxを定義して、それを出力する
sample_fanc <- function() {
  x <- 3
  x
}

# 関数の外でxを定義
x <- 5

# 関数を実行
sample_fanc()

# 関数の外側xの値は変化しない
x


## スーパーアサインメント演算子

# 関数の外側にあるxの値を変化させる
sample_func_2 <- function() {
  x <<-  3
  x
}

# 関数の外側でxを作成
x <- 5

# 関数を実行
sample_func_2()

# xの値が変化する
x


## 関数の中で定義されていない変数を使用する例

# 関数の外側にあるxの値を参照する
sample_func_3 <- function() {
  x
}

# 関数の外側でxを作成
x <- 5

# 関数を実行
sample_func_3()


