
# パイプ演算子|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# パッケージの読み込み --------------------------------------------------------------

library(magrittr)


# パイプ演算子を使ってみる ------------------------------------------------------------

# パイプ演算子の例
temperature <- c(20, 19, 23)
temperature %>% mean()

# パイプ演算子を使わない例
temperature <- c(20, 19, 23)
mean(temperature)


# 相対度数と累積相対度数を得る ----------------------------------------------------------

## 相対度数を得るための様々な実装

# データの読み込み
favorite_food <- read.csv("2-9-6-favorite-food.csv")
target_data <- favorite_food$favorite_food
target_data

# パイプ演算子を使わない方法
freq <- table(target_data)
freq
prop.table(freq)

# freqを残さない方法
prop.table(table(target_data))

# パイプ演算子を使う方法
target_data %>% table() %>% prop.table()


## パイプ演算子を活用した累積相対度数の計算

# 累積相対度数を得る
target_data %>% table() %>% prop.table() %>% cumsum()

# 行を分ける
target_data %>% 
  table() %>% 
  prop.table() %>% 
  cumsum()


# 引数の与え方 ------------------------------------------------------------------

# 第二引数以降を指定できる
data_height <- read.csv("2-1-1-height.csv")
data_height %>% head(n = 3)
# head(data_height, n = 3)と同じ

# 左側の結果を第二引数以降にする場合はピリオドを使う
data_height %>% 
  lm(formula = children ~ parents, data = .) %>% 
  summary()


# tee演算子 ---------------------------------------------------------

## パイプ演算子の課題

# これはうまくいかない
result_1 <- target_data %>% 
  table() %>% 
  barplot()

# 結果の出力
result_1


## tee演算子の活用

# %T>%を使うとうまくいく
result_2 <- target_data %>% 
  table() %T>% 
  barplot()

# 結果の出力
result_2

# さらにパイプをつなげることも可能
result_3 <- target_data %>% 
  table() %T>% 
  barplot() %>% 
  prop.table()

# 結果の出力
result_3


# expositionパイプ演算子 -----------------------------------------------------------------

## expositionパイプ演算子の基本

# データの読み込み
sales_meat <- read.csv("2-9-4-sales-meat.csv")
sales_meat %>% head(n = 3)

# 通常の方法を使って列を抽出
sales_meat$sales

# expositionパイプ演算子を使って列を抽出
sales_meat %$% sales


## expositionパイプ演算子の活用

# カテゴリー別の売り上げ平均値の計算
tapply(sales_meat$sales, sales_meat$category, mean)

# expositionパイプ演算子を使う
sales_meat %$% tapply(sales, category, mean)

# さらにパイプをつなげる
sales_meat %$% tapply(sales, category, mean) %>% barplot()


# 複合割り当てパイプ演算子 -----------------------------------------------------------------

# データの標準化
sales_beef <- read.csv("2-9-1-sales-beef.csv")
scale(sales_beef$beef)

# すなおに代入
sales_beef$beef <- scale(sales_beef$beef)
sales_beef %>% head(n = 3)

# 複合割り当てパイプ演算子を活用
sales_beef <- read.csv("2-9-1-sales-beef.csv")
sales_beef$beef %<>% scale()
sales_beef %>% head(n = 3)


