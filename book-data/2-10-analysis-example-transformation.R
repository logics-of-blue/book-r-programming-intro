
# 3行以下で終わる分析の例：変換編|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# ベクトルの入力・ベクトルの出力(ブロードキャスト) -----------------------------------------------

# 対象データ
vec_num <- 1:5
# 集計(5つの要素が1つの計算結果になる)
sum(vec_num)

# 5つの要素1つ1つが対数変換される
log(vec_num)


# 標準化 ---------------------------------------------------------------------

# 標準化
sales_beef <- read.csv("2-9-1-sales-beef.csv")
scale(sales_beef$beef)


# memo：scale関数を使わないで標準化を行う
mu <- mean(sales_beef$beef)
sigma <- sd(sales_beef$beef)
(sales_beef$beef - mu) / sigma


# 変換結果の保存 -----------------------------------------------------------------

# 変換結果の保存
sales_beef <- read.csv("2-9-1-sales-beef.csv")
sales_beef$beef_scale <- scale(sales_beef$beef)
sales_beef


