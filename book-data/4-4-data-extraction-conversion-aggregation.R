
# データの抽出・変換・集計|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# パッケージの読み込み --------------------------------------------------------------

library(magrittr)
library(readr)
library(dplyr)


# 列の抽出 -----------------------------------------------------------

## データの読み込み

# 対象のデータ
sales_beef_region <- read_csv("2-9-2-sales_beef_region.csv")
sales_beef_region


## select関数の基本

# 列名を指定して抽出
select(sales_beef_region, beef)


## 特定の列を除く

# 特定の列を除く
select(sales_beef_region, -beef)


## パイプ演算子の活用

# パイプの使用
sales_beef_region %>% select(beef)


## 複数の列の抽出

# 複数の列の抽出
iris %>% 
  as_tibble() %>% 
  select(Sepal.Length, Species) %>% 
  print(n = 3)


# memo：select関数を使わずに列を抽出する方法
# $記号を使った列の抽出
sales_beef_region$beef
# [[]]記号を使った列の抽出
sales_beef_region[["beef"]]
# 参考：drop = FALSEは不要
sales_beef_region[, "beef"]
# data.frameとの比較
as.data.frame(sales_beef_region)[, "beef"]
as.data.frame(sales_beef_region)[, "beef", drop = FALSE]


# memo：pull関数を使った列の抽出
sales_beef_region %>% pull(beef)


# 条件を指定した行の抽出 -----------------------------------------------------------

## データの読み込み

# 対象のデータ
sales_meat <- read_csv(
  "2-9-4-sales-meat.csv", 
  col_types = cols(category = col_factor()))
sales_meat


## filter関数の基本

# categoryがporkのデータのみを抽出
sales_meat %>% filter(category == "pork")

# 売り上げが40万円以上のデータのみを抽出
sales_meat %>% filter(sales >= 40)


## 複数の条件を指定する

# 売り上げが40万円以上、かつ、
# categoryがporkのデータのみを抽出
sales_meat %>% filter(sales >= 40 & category == "pork")


# memo：複数条件の指定の方法
# &条件は、カンマ区切りでもよい
sales_meat %>% filter(sales >= 40, category == "pork")


# 売り上げが40万円以上、または
# 売り上げが20万円以下のデータのみを抽出
sales_meat %>% filter(sales >= 40 | sales <= 20)


# memo：行番号を指定して抽出
sales_meat %>% slice(1:3)


# 並び替え ----------------------------------------------------------

## arrange関数の基本

# 昇順
sales_beef_region %>% arrange(beef)

# 降順
sales_beef_region %>% arrange(desc(beef))


## 2つ以上の列を参照した並び替え

# 2列を参照
sales_meat %>% arrange(category, sales)


# memo：上位n位までを取得
sales_beef_region %>% 
  arrange(desc(beef)) %>% 
  slice(1:3)
# top_n関数を使う
sales_beef_region %>% top_n(3, beef)


# 列名の変更 ----------------------------------------------------------

# 列名を変更する
sales_beef_region %>% 
  rename(uriage = beef, timei = region) %>% 
  print(n = 3)


# データの変換 ---------------------------------------------------------

## データの読み込み

# 対象のデータ
sales_population <- read_csv("2-9-3-sales-population.csv")
sales_population


## mutate関数の基本

# 対数変換をしたデータ列を追加
sales_population %>% 
  mutate(log_beef = log(beef))

# 2つの列を追加
sales_population %>% 
  mutate(log_beef = log(beef),
         log_population = log(resident_population))


## mutate関数の応用

# 組み合わせ
# 人口当たり売上列を追加してソート
sales_population %>% 
  mutate(sales_per_population = beef / resident_population) %>% 
  arrange(desc(sales_per_population))


# memo：上位n位までを取得
# 順位を得る
sales_beef_region %>% 
  mutate(rank = row_number(desc(beef)))
# 順位が3以下のものを取得
sales_beef_region %>% 
  mutate(rank = row_number(desc(beef))) %>% 
  filter(rank <= 3)
# 順位が3以下のものを取得(簡易版)
sales_beef_region %>% 
  filter(row_number(desc(beef)) <= 3)


# データの集計 ------------------------------------------------------

# 平均値の計算
sales_meat %>% 
  summarise(sales_mean = mean(sales))

# 平均値・最大値・最小値の計算
sales_meat %>% 
  summarise(sales_mean = mean(sales),
            sales_max = max(sales),
            sales_min = min(sales))


# グループ別の集計 ----------------------------------------------------

# category別の平均値の計算
sales_meat %>% 
  group_by(category) %>% 
  summarise(sales_mean = mean(sales))

# 複数の集計値をまとめて計算
sales_meat %>% 
  group_by(category) %>% 
  summarise(sales_mean = mean(sales),
            sales_max = max(sales),
            sales_min = min(sales))


# 少し複雑な集計事例 ---------------------------------------------------------------

## カテゴリー別に順位1位のデータを取得する

# beefとporkで各々の売り上げ1位を取得する
sales_meat %>% 
  group_by(category) %>% 
  filter(row_number(desc(sales)) == 1)

# 分解して考える
sales_meat %>% 
  group_by(category) %>% 
  mutate(rank = row_number(desc(sales)))

# これで目的達成
sales_meat %>% 
  group_by(category) %>% 
  mutate(rank = row_number(desc(sales))) %>% 
  filter(rank == 1)


## 2つ以上のカテゴリ別に分けた集計

# 対象データ
warpbreaks %>% head(n = 3)

# ウールの種類別、糸の張力別の切断数平均値を得る
warpbreaks %>% 
  group_by(wool, tension) %>% 
  summarise(mean_breaks = mean(breaks))


