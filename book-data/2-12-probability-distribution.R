
# 確率分布|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# 単純ランダムサンプリングのシミュレーション ------------------------------------------------------------

# 単純ランダムサンプリング
population <- rep(c(1,0), each = 5000)
sample(x = population, size = 1)

# 結果は毎回変わる
sample(x = population, size = 1)
sample(x = population, size = 1)

# 10サンプルを取得する
sample(x = population, size = 10)


# 乱数の種の指定 -----------------------------------------------------------------

# 乱数の種の指定
set.seed(1)
sample(x = population, size = 10)

set.seed(1)
sample(x = population, size = 10)


# 復元抽出と非復元抽出 --------------------------------------------------------------

# 復元抽出
set.seed(1)
population_2 <- c(1,0)
sample(x = population_2, size = 10, replace = TRUE)


# 二項分布 --------------------------------------------------------------------

## dbinom関数による二項分布の確率密度関数の実装

# 確率質量関数
dbinom(x = 3, size = 10, prob = 0.2)

# 以下の計算結果と同じ
p <- 0.2
n <- 10
x <- 3
choose(n, x) * p^x * (1 - p)^(n - x)

# 可視化
x <- 0:10
binom_probs <- dbinom(x = x, size = 10, prob = 0.2)
plot(x = x, y = binom_probs, type = "l")


## pbinom関数による累積分布関数の実装

# 累積確率
pbinom(q = 3, size = 10, prob = 0.2)

# 以下の計算結果と同じ
dbinom(x = 0, size = 10, prob = 0.2) +
  dbinom(x = 1, size = 10, prob = 0.2) +
  dbinom(x = 2, size = 10, prob = 0.2) +
  dbinom(x = 3, size = 10, prob = 0.2)


## qbinom関数による分位点の計算

# ある累積確率を取る点
qbinom(p = 0.8791261, size = 10, prob = 0.2)


## rbinom関数による乱数の生成

# 乱数の生成
set.seed(1)
rbinom(n = 1, size = 10, prob = 0.2)

set.seed(1)
rbinom(n = 5, size = 10, prob = 0.2)


# memo：R言語における乱数生成手法
runif(5)
?Random

# 正規分布 --------------------------------------------------------------------

## dnorm関数による確率密度関数の実装

# 確率密度関数
dnorm(x = 0.5, mean = 0, sd = 1)

# 以下の計算結果と同じ
x <- 0.5
mu <- 0
sigma <- 1
1 / (sqrt(2 * pi) * sigma) * exp(-((x - mu) ^ 2) / (2 * sigma ^ 2))

# 可視化
x <- seq(from = -3, to = 3, by = 0.01)
norm_probs <- dnorm(x = x, mean = 0, sd = 1)
plot(x = x, y = norm_probs, type = "l")


## qnorm関数による累積分布関数の実装

# 累積確率
pnorm(q = 0.5, mean = 0, sd = 1)


## qnorm関数による分位点の実装

# ある累積確率を取る点
qnorm(p = 0.975, mean = 0, sd = 1)


## rnorm関数による乱数の生成

# 乱数の生成
set.seed(1)
rnorm(n = 5, mean = 0, sd = 1)


# その他の確率分布 ----------------------------------------------------------------

# ポアソン分布
ppois(q = 2, lambda = 5)

# t分布
pt(q = 1, df = 3)

# F分布
pf(q = 1, df1 = 2, df2 = 2)

# χ二乗分布
pchisq(q = 2, df = 5)


