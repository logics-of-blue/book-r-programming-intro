
# 3行以下で終わる分析の例：可視化編|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# ヒストグラム ------------------------------------------------------------------

# ヒストグラム
sales_beef <- read.csv("2-9-1-sales-beef.csv")
hist(x = sales_beef$beef)


# memo：グラフの設定
hist(
  x = sales_beef$beef,
  main = "お肉の売り上げヒストグラム",
  xlab = "お肉の売り上げ",
  ylab = "度数"
)


# memo：度数の取得
freq_hist <- hist(x = sales_beef$beef)
freq_hist
# これでも良い
hist(x = sales_beef$beef, plot = FALSE)


# memo：階級の変更
freq_break <- hist(sales_beef$beef, 
                   breaks = c(25,28,33,37,40))
freq_break


# memo：縦軸における度数と密度の切り替え
hist(x = sales_beef$beef, freq = TRUE)
hist(x = sales_beef$beef, probability = TRUE)


# 棒グラフ --------------------------------------------------------------------

# 棒グラフ
sales_beef_region <- read.csv("2-9-2-sales_beef_region.csv")
barplot(formula = beef ~ region, 
        data = sales_beef_region, las = 2)


# memo：formulaを使わない方法
barplot(height = sales_beef_region$beef, 
        names.arg = sales_beef_region$region, las = 2)


# memo：固有のラベルがついていなければエラーになる
# 固有の名称がついている
sales_beef_region
# これはエラー
sales_meat <- read.csv("2-9-4-sales-meat.csv")
head(sales_meat, n = 3)
barplot(formula = sales ~ category, data = sales_meat, las = 2)


# 集計値に対する棒グラフ -------------------------------------------------------------

# 集計値に対する棒グラフ
sales_meat <- read.csv("2-9-4-sales-meat.csv")
m_sales <- tapply(sales_meat$sales, sales_meat$category, mean)
barplot(height = m_sales)


# memo：集計と可視化の関係
# カテゴリーごとの売り上げ平均が記録されている
m_sales
names(m_sales)


# 箱ひげ図 --------------------------------------------------------------------

# 箱ひげ図
sales_meat <- read.csv("2-9-4-sales-meat.csv")
boxplot(formula = sales ~ category, data = sales_meat)


# memo：ひげの長さと外れ値
sales_meat2 <- rbind(
  sales_meat,
  data.frame(category = "beef", sales = 87)
)
boxplot(formula = sales ~ category, data = sales_meat2)


# 散布図 ---------------------------------------------------------------------

# 散布図
sales_population <- read.csv("2-9-3-sales-population.csv")
plot(formula = beef ~ resident_population, 
     data = sales_population)


# memo：散布図の作り方と散布図の解釈
head(sales_population, n = 3)


# 散布図行列 -------------------------------------------------------------------

# 散布図行列
pairs(iris)


# memo：参考：irisデータの中身
head(iris, n = 3)


# グラフのファイル出力②：プログラムを書く --------------------------------------------------------------

# グラフのファイル出力
png(filename = "result.png")
pairs(iris)
dev.off()


# memo：グラフの大きさとフォントを指定
svg(
  filename = "result.svg",
  width = 6,
  height = 6,
  family="MS Gothic"
)
pairs(iris)
dev.off()


# memo：グラフィックデバイスについて
# 現在のグラフィックデバイス
pairs(iris)
dev.cur()
# PNGファイルに出力する場合
png(filename = "result.png")
dev.cur()
pairs(iris)
# ファイルのクローズ
dev.off()

