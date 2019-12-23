
# データの読み込み|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# パッケージの読み込み --------------------------------------------------------------

library(magrittr)
library(tibble)
library(readr)


# data.frameとtibble ---------------------------------------------------------

## data.frameとtibbleの作成

# data.frameとtibbleの作成
df_1  <- data.frame(x = 1:5, y = letters[1:5])
tbl_1 <- tibble(x = 1:5, y = letters[1:5])


## data.frameとtibbleの違い

# データをコンソールの表示
df_1
tbl_1

# 文字列の扱いの違い
class(df_1$y)
class(tbl_1$y)


## data.frameをtibbleに変換する

# data.frameをtibbleに変換
iris %>% as_tibble()


## tibbleの出力に関する補足

# すべての行と列を出力
iris %>% as_tibble() %>% print(n = 10000, width = 10000)


# memo：tibbleのそのほかの作成方法
tribble(
  ~x, ~y,
  1,  "a",
  2,  "b",
  3,  "c",
  4,  "d",
  5,  "f")


# readrパッケージによるデータの読み込み ---------------------------------------------------

# データの読み込み
sales_beef        <- read_csv("2-9-1-sales-beef.csv")
sales_beef_region <- read_csv("2-9-2-sales_beef_region.csv")
sales_meat        <- read_csv("2-9-4-sales-meat.csv")

# データの内容のチェック
sales_beef %>% print(n = 3)
sales_beef_region %>% print(n = 3)
sales_meat %>% print(n = 3)


# データの型の変換 -------------------------------------------------------------

## データを読み込む際に、データ型を指定する

# factorとして読み込む
sales_meat <- read_csv(
  "2-9-4-sales-meat.csv",
  col_types = cols(category = col_factor())
)

sales_meat %>% print(n = 3)


# 参考：さまざまなデータ型の指定
col_factor()    # factor型
col_logical()   # 論理値型
col_integer()   # 整数型
col_double()    # 実数値型
col_character() # 文字列型


## tibbleを対象に、データ側を変換する

# charactorとして読み込んでから変換する
sales_meat <- read_csv("2-9-4-sales-meat.csv")

# これはcategoryが<chr> 
sales_meat %>% print(n = 3)

# 変換する
sales_meat$category <- parse_factor(sales_meat$category) 

# これはcategoryが<fct>になった
sales_meat %>% print(n = 3)


# 参考：さまざまな変換(引数には文字列型のベクトルを渡すこと)
parse_factor("1")
parse_logical("true")
parse_integer("1")
parse_double("1.2")


# 囲み文字と区切り文字の変更 -------------------------------------------------------------

## ダブルクォーテーションマークで囲まれたデータの読み込み

# ダブルクォーテーション
greet_ok_1 <- read_csv(file = "2-7-2-double-quote.csv")
greet_ok_1


## シングルクォーテーションマークで囲まれたデータの読み込み

# シングルクォーテーション
greet_ok_2 <- read_csv(file = "2-7-3-single-quote.csv",
                       quote = "'")
greet_ok_2


## タブ区切りデータの読み込み

# タブ区切りの読み込み
height_tsv <- read_tsv(file = "2-7-4-height.tsv")
height_tsv %>% print(n = 3)

# これでもOK
height_tsv_delim <- read_delim(file = "2-7-4-height.tsv",
                               delim = "\t")
height_tsv_delim %>% print(n = 3)


# クリップボードからのデータ読み込み ----------------------------------------------------------

# クリップボードからの読み込み
data_clip <- read_tsv(clipboard())
data_clip %>% print(n = 3)


# 文字コードがもたらすエラーの対処 --------------------------------------------------------

## 文字コードがshift-jisであるファイルの読み込み

# shift-jisはうまくいかない
read_sjis <- read_csv("2-7-6-shift-jis.csv")
read_sjis %>% print(n = 3)

# 文字コードを指定(デフォルトはUTF-8)
read_sjis <- read_csv("2-7-6-shift-jis.csv",
                      locale = locale(encoding = "SJIS"))
read_sjis %>% print(n = 3)


## 文字コードがUTF-8であるファイルの読み込み

# UTF-8のファイルを読み込む
read_utf8 <- read_csv("2-7-7-utf-8.csv",
                      locale = locale(encoding = "UTF-8"))
read_utf8 %>% print(n = 3)


# -999を欠損値として解釈する ------------------------------------------------------------------

#  そのまま読み込み
read_csv("4-3-1-sales-beef-999.csv")

# -999を欠損(NA)として読み込み
read_csv("4-3-1-sales-beef-999.csv", na = "-999")


# CSVファイルの出力 -----------------------------------------------------------------

# tibbleの作成
tbl_crab <- tibble(
  sex = c("male", "male", "male", "female", "female", "female"),
  shell_width    = c(13.8, 14.3, 14.1, 6.8, 7.2, 6.5),
  scissors_width = c( 2.8,  3.2,  3.1, 1.8, 2.3, 2.1)
)

# CSVファイルの出力
write_csv(tbl_crab, path = "crab-tbl.csv")


