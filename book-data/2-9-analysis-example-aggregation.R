
# 3行以下で終わる分析の例：集計編|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# サンプルサイズの取得 --------------------------------------------------------------

# サンプルサイズの取得 
sales_beef <- read.csv("2-9-1-sales-beef.csv")
nrow(sales_beef)


# 度数 ------------------------------------------------------------

# 2カテゴリの場合の度数
fish_chicken <- read.csv("2-9-5-fish-chicken.csv")
table(fish_chicken$sex)
table(fish_chicken$choice)


# memo：3カテゴリ以上の場合
favorite_food <- read.csv("2-9-6-favorite-food.csv")
table(favorite_food$sex)
table(favorite_food$favorite_food)


# 累積度数 -----------------------------------------------------------------

# 累積度数 
favorite_food <- read.csv("2-9-6-favorite-food.csv")
freq <- table(favorite_food$favorite_food)
cumsum(freq)


# memo：関数を入れ子にする
# 以下のコードでも実行結果は変わらない
favorite_food <- read.csv("2-9-6-favorite-food.csv")
cumsum(table(favorite_food$favorite_food))


# memo：cumsum関数の補足
# 「１」が5つあるデータの累積値
cumsum(c(1, 1, 1, 1, 1))
# 「１から５の等差数列」の累積値
cumsum(c(1, 2, 3, 4, 5))


# 相対度数 --------------------------------------------------------------------

# 相対度数
favorite_food <- read.csv("2-9-6-favorite-food.csv")
freq <- table(favorite_food$favorite_food)
prop.table(freq)


# memo：prop.tableの補足
# prop.tableの例
prop.table(c(20, 30, 50))
# prop.tableを使わない方法
c(20, 30, 50) / sum(c(20, 30, 50))


# memo：累積相対度数
favorite_food <- read.csv("2-9-6-favorite-food.csv")
freq <- table(favorite_food$favorite_food)
prop <- prop.table(freq)
cumsum(prop)


# クロス集計 ----------------------------------------------------------

# 2カテゴリの場合のクロス集計
fish_chicken <- read.csv("2-9-5-fish-chicken.csv")
table(fish_chicken)


# memo：3カテゴリの場合
favorite_food <- read.csv("2-9-6-favorite-food.csv")
table(favorite_food)


# memo：prob.tableを使って合計値が1になるようにする
favorite_food <- read.csv("2-9-6-favorite-food.csv")
freq_cross <- table(favorite_food)
prop.table(freq_cross)


# クロス集計表⇔整然データの変換 ---------------------------------------------------------

# クロス集計表をデータフレームにする
favorite_food <- read.csv("2-9-6-favorite-food.csv")
freq_cross <- table(favorite_food)
as.data.frame(freq_cross)


# memo：データフレームをまたクロス集計表に変換する
# クロス集計(xtabs)
freq_df <- as.data.frame(freq_cross)
xtabs(
  formula = Freq ~ sex + favorite_food, 
  data = freq_df
)


# 合計値 ---------------------------------------------------------------------

# 合計値
sales_beef <- read.csv("2-9-1-sales-beef.csv")
sum(sales_beef$beef)


# memo：2列以上あるデータに対する合計値の計算
sales_population <- read.csv("2-9-3-sales-population.csv")
sum(sales_population$beef)
sum(sales_population$resident_population)


# 平均値 ---------------------------------------------------------------------

# 平均値
sales_beef <- read.csv("2-9-1-sales-beef.csv")
mean(sales_beef$beef)


# memo：mean関数を使わないで平均値を計算する
sum_sales <- sum(sales_beef$beef)
sample_size <- nrow(sales_beef)
sum_sales / sample_size


# 不偏分散 --------------------------------------------------------------------

# 不偏分散
sales_beef <- read.csv("2-9-1-sales-beef.csv")
var(sales_beef$beef)


# memo：var関数を使わないで不偏分散を計算する
mean_sales <- mean(sales_beef$beef)
sample_size <- nrow(sales_beef)
sum((sales_beef$beef - mean_sales) ^ 2) / (sample_size - 1)


# 標準偏差 --------------------------------------------------------------------

# 標準偏差
sales_beef <- read.csv("2-9-1-sales-beef.csv")
sd(sales_beef$beef)


# memo：sd関数を使わないで標準偏差を計算する
var_sales <- var(sales_beef$beef)
sqrt(var_sales)


# データの並び替え ----------------------------------------------------------------

# データの並び替え
sales_beef <- read.csv("2-9-1-sales-beef.csv")
sort(sales_beef$beef)


# memo：降順に並び替える
sort(sales_beef$beef, decreasing = TRUE)


# memo：順位の取得と並び替え
# 元のデータ
sales_beef$beef
# 順位(昇順)
order(sales_beef$beef)
# 並び替え
sales_beef$beef[order(sales_beef$beef)]


# 最小・最大値 ------------------------------------------------------------------

# 最小・最大値
sales_beef <- read.csv("2-9-1-sales-beef.csv")
min(sales_beef$beef)
max(sales_beef$beef)


# memo：データの範囲を取得する
range_sales <- range(sales_beef$beef)
range_sales
# 最小値の取得
range_sales[1]


# memo：minやmax関数を使わないで、最小・最大を求める
sort(sales_beef$beef)[1]
sort(sales_beef$beef)[nrow(sales_beef)]


# 中央値 ---------------------------------------------------------------------

# 中央値
sales_beef <- read.csv("2-9-1-sales-beef.csv")
median(sales_beef$beef)


# memo：中央値の計算例
median(1:5)
median(1:4)
(30.9 + 31.6) / 2
# sort関数を使って中央値を求める
n <- nrow(sales_beef)
sorted <- sort(sales_beef$beef)
(sorted[n / 2] + sorted[(n / 2) + 1]) / 2


# パーセント点 ------------------------------------------------------------------

# パーセント点(分位点)
sales_beef <- read.csv("2-9-1-sales-beef.csv")
quantile(sales_beef$beef, probs = c(0.25, 0.75))


# memo：quantile関数を使って中央値を求める
quantile(sales_beef$beef, probs = 0.5)


# memo：パーセント点の計算例
quantile(0:100, probs = c(0.25, 0.5, 0.75))
quantile(0:10, probs = c(0.25, 0.5, 0.75))


# 四分位範囲 -------------------------------------------------------------------

# 四分位範囲
sales_beef <- read.csv("2-9-1-sales-beef.csv")
IQR(sales_beef$beef)


# memo：IQR関数を使わないで四分位範囲を求める
q1 <- quantile(sales_beef$beef, probs = 0.25)
q3 <- quantile(sales_beef$beef, probs = 0.75)
q3 - q1


# 要約統計量 -------------------------------------------------------------------

# 要約統計量
sales_beef <- read.csv("2-9-1-sales-beef.csv")
summary(sales_beef$beef)


# memo：列名を指定しない場合
summary(sales_beef)


# memo：2列以上のデータに対して適用した場合
sales_meat <- read.csv("2-9-4-sales-meat.csv")
summary(sales_meat)


# 行や列に対する一括処理(apply) ---------------------------------------------------------------

# 列に対する一括処理
sales_population <- read.csv("2-9-3-sales-population.csv")
apply(sales_population, 2, sum)


# memo：行に対する一括処理
sales_population <- read.csv("2-9-3-sales-population.csv")
apply(sales_population, 1, sum)


# リストに対する一括処理(lapply) -----------------------------------------------------

# リストを入力、リストを出力
sales_population <- read.csv("2-9-3-sales-population.csv")
lapply(sales_population, sum)


# リストに対する一括処理(sapply) -----------------------------------------------------

# リストを入力、行列を出力
sales_population <- read.csv("2-9-3-sales-population.csv")
sapply(sales_population, sum)


# カテゴリ別の集計値(tapply) --------------------------------------------------------------

# カテゴリ別の平均値
sales_meat <- read.csv("2-9-4-sales-meat.csv")
tapply(sales_meat$sales, sales_meat$category, mean)


# memo：カテゴリ別の要約統計量
tapply(sales_meat$sales, sales_meat$category, summary)


# 2つ以上のカテゴリ別に分けた集計値(tapply) -------------------------------------------------------

# ウールの種類別、糸の張力別の切断数合計値を得る
tapply(warpbreaks$breaks, 
       list(warpbreaks$wool, warpbreaks$tension), 
       mean)


