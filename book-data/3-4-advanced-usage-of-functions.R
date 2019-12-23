
# 関数の応用的な使い方|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# lapply関数の復習 -------------------------------------------------------------

# 対象となるデータ
target <- list(
  data_1 = 1:5,
  data_2 = 11:14
)
# データの確認
target

# データを対数変換する
lapply(target, log)


# 無名関数 --------------------------------------------------------------------

## 名前がついている関数

# 1を足す関数
plus_one <- function(x) {
  x + 1
}

# すべての値に1を足す
lapply(target,　plus_one)


## 無名関数

# 無名関数の使用
lapply(target, function(x) x + 1)


# 数値微分の実装 ---------------------------------------------------------------

## 数値微分を行う関数の作成

# 微分係数を返す関数
differential <- function(f, x, h = 1e-7) {
  (f(x + h) - f(x)) / h
}


## 数値微分の実行

# 微分したい関数
target_func <- function(x) {
  x ^ 2
}

# x=3の時の微分係数を求める
differential(f = target_func, x = 3)


# integrateによる数値積分 --------------------------------------------------------

## integrateによる数値積分

# target_funcを0から1の間で積分
integrate(f = target_func, lower = 0, upper = 1)


## 無名関数を使う例

# 無名関数を0から1の間で積分
integrate(
  f = function(x) x ^ 3,
  lower = 0, 
  upper = 1
)


# unirootを使って関数値が0になる点を調べる ------------------------------------------------

## 対象となる関数の作成

# 0になる点を調べたい関数
target_func_2 <- function(x) {
  x ^ 3 - 8
}

# 関数の可視化
x <- seq(from = -2, to = 3, by = 0.01)
y <- target_func_2(x)
plot(y ~ x, type = "l")
abline(h = 0, v = 0, lwd = 2)


## unirootによる方程式の根の計算

# 0になる点を調べる
uniroot(f = target_func_2, interval = c(-2, 3))


## 無名関数を使う例

# 無名関数を使う
uniroot(f = function(x) x ^ 3 - 8, interval = c(-2, 3))


# memo：多項式の根を求める
# f(x) = -8*x^0 + 0*x^1 + 0*x^2 + 1*x^3 
polyroot(c(-8, 0, 0, 1))


# optimizeによる最適化 -------------------------------------------------------

## 対象となる関数の作成

# 最大をとる点を調べたい関数
target_func_3 <- function(x) {
  -1 * x ^ 2 + 4 * x + 3
}

# 関数の可視化
x <- seq(from = -2, to = 5, by = 0.01)
y <- target_func_3(x)
plot(y ~ x, type = "l")
abline(h = 0, v = 0, lwd = 2)


## optimizeによる最適化

# 関数の値を最大化する点を調べる
optimize(
  f = target_func_3,
  interval = c(0, 5),
  maximum = TRUE
)


## 無名関数を使う例

# 無名関数を使う例
optimize(
  f = function(x) -1 * x ^ 2 + 4 * x + 3,
  interval = c(0, 5),
  maximum = TRUE
)


# optimによる最適化 ----------------------------------------------------------

## 対象となる関数の作成

# 残差平方和を計算する関数
calc_rss <- function(pars) {
  y_hat <- pars[1] + pars[2] * x
  sum((y - y_hat) ^ 2)
}

# データの読み込み
data_height <- read.csv("2-1-1-height.csv")
head(data_height, n = 3)

x <- data_height$parents
y <- data_height$children

# 残差平方和の計算
calc_rss(pars = c(100, 0.5))


## optimによる最適化

# 残差平方和を最小にする傾きと切片を得る
optim(
  par = c(1, 1), # パラメータの初期値
  fn = calc_rss  # 最小にしたい関数
)

# lm関数を使って得られたパラメータと比較
lm(y ~ x)


# memo：最適化のアルゴリズムの変更
# Nelder-Mead法
optim(
  par = c(1, 1), # パラメータの初期値
  fn = calc_rss, # 最小にしたい関数
  method = "Nelder-Mead"
)
# BFGS法
optim(
  par = c(1, 1), # パラメータの初期値
  fn = calc_rss, # 最小にしたい関数
  method = "BFGS"
)



