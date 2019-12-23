
# 入出力|R言語ではじめるプログラミングとデータ分析
# 馬場真哉

# 注意事項
# C:\r_analysisにプロジェクトがあることを前提としたコードです


# CSVファイルの読み込みの基本 ---------------------------------------------------------

# CSVファイルの読み込み
height_csv <- read.csv(file = "2-1-1-height.csv")

# 先頭行の取得
head(height_csv, n = 3)

# 読み込まれたデータはデータフレームになっている
class(height_csv)

# 読み込まれたデータは、10行2列になっている
dim(height_csv)


# read.table関数の使い方 ----------------------------------------------------------------

## read.table関数は、そのままだとデータを正しく読み込めない

# これだとうまくいかない
height_table_dame <- read.table(file = "2-1-1-height.csv")

# 先頭行の取得
head(height_table_dame, n = 3)

# 行数と列数の確認
dim(height_table_dame)


## 区切り文字の指定

# 区切り文字の指定
height_table <- read.table(
  "2-1-1-height.csv", 
  sep = ","
)

# 先頭行の取得
head(height_table, n = 3)

# 行数と列数の確認
dim(height_table)


## ヘッダーの指定

# 区切り文字とヘッダーの指定
height_table_header <- read.table(
  file = "2-1-1-height.csv", 
  sep = ",",
  header = TRUE
)

# 先頭行の取得
head(height_table_header, n = 3)

# 行数と列数の確認
dim(height_table_header)

# ヘルプの参照
?read.table


# クォーテーションで囲まれたデータを読み込む ---------------------------------------------------

## データをうまく読み込めない事例

# これではうまくいかない
greet_dame_1 <- read.csv(
  file = "2-7-1-included-comma.csv", 
  stringsAsFactors = FALSE
)
greet_dame_1
greet_dame_1$greet


## ダブルクォーテーションマークを用いる例

# ダブルクォーテーションで囲むと良い
greet_ok_1 <- read.csv(
  file = "2-7-2-double-quote.csv", 
  stringsAsFactors = FALSE
)
greet_ok_1
greet_ok_1$greet


## シングルクォーテーションマークを用いる例
# シングルクォーテーションの場合は
# quoteを指定すれば、正しく読み込める
greet_ok_2 <- read.csv(
  file = "2-7-3-single-quote.csv", 
  stringsAsFactors = FALSE, 
  quote = "'"
)
greet_ok_2
greet_ok_2$greet


# 参考：エスケープと\マーク
# 明示的にダブルクォーテーションで囲まれていることを指定
greet_ok_3 <- read.csv(
  file = "2-7-2-double-quote.csv", 
  stringsAsFactors = FALSE,
  quote = "\""
)
greet_ok_3
greet_ok_3$greet


# タブ区切りデータを読み込む -----------------------------------------------------------

# タブ区切りデータを読み込む
height_tsv <- read.delim(file = "2-7-4-height.tsv")
head(height_tsv, n = 3)

# これでもOK
height_tsv_table <- read.table(
  file = "2-7-4-height.tsv",
  sep = "\t",
  header = TRUE
)
head(height_tsv_table, n = 3)


# Excelからコピー＆ペーストでデータを読み込む ------------------------------------------------

# クリップボードからの読み込み
height_copy_paste <- read.delim(file = "clipboard")
head(height_copy_paste, n = 3)

# Macの場合
# read.delim(pipe("pbpaste"))

# これでもOK
height_copy_paste_table <- read.table(
  file = "clipboard",
  sep = "\t",
  header = TRUE
)
head(height_copy_paste_table, n = 3)


# 文字コードがもたらすエラーの対処 -----------------------------------------------------------------------

## 文字コードがShift-JISであるファイルの読み込み
# SJISは大丈夫
read_sjis <- read.csv("2-7-6-shift-jis.csv")
head(read_sjis, n = 3)


## 文字コードがもたらすエラー

# 以下はエラーになる
read_utf8_err <- read.csv("2-7-7-utf-8.csv")


## 文字コードがUTF-8であるデータの読み込み

# 文字コードを指定すると読み込める
read_utf8 <- read.csv(
  "2-7-7-utf-8.csv", 
  fileEncoding = "UTF-8"
)
head(read_utf8, n = 3)


# 参考：SJISを明示的に読み込む
read_sjis_2 <- read.csv(
  "2-7-6-shift-jis.csv", 
  fileEncoding = "SJIS"
)
head(read_sjis_2, n = 3)


# 離れた場所に配置されているファイルを読み込む --------------------------------------------------

##  絶対パスの指定

# 絶対パスを指定
height_csv_2 <- read.csv(
  file = "C:\\r_analysis\\data\\2-1-1-height.csv"
)

# 確認
head(height_csv_2, n = 3)

# スラッシュ記号を使う
height_csv_3 <- read.csv(
  file = "C:/r_analysis/data/2-1-1-height.csv"
)

# 確認
head(height_csv_3, n = 3)


## 相対パスの指定

# 相対パスを指定
height_csv_4 <- read.csv(
  file = "./data/2-1-1-height.csv"
)

# 確認
head(height_csv_4, n = 3)

# 参考：\を2つつなげるやり方でもよい
read.csv(
  file = ".\\data\\2-1-1-height.csv"
)

# 遠くの場所の相対パスを指定
height_csv_5 <- read.csv(
  file = "../data_folder/2-1-1-height.csv"
)

# 確認
head(height_csv_5, n = 3)


# 作業ディレクトリを変更して、データを読み込みやすくする ---------------------------------------------

## getwd関数による作業ディレクトリの確認

# 作業ディレクトリの確認
getwd()


## setwd関数による作業ディレクトリの変更

# 作業ディレクトリの変更
setwd("C:/data_folder")
getwd()


# Rにもともと用意されているデータを読み込む ---------------------------------------------------

# アヤメの調査データ
head(iris, n = 3)

# 糸の切断数データ
head(warpbreaks, n = 3)


# データフレームをCSVファイルに保存する ----------------------------------------------------

## 出力データの作成

# データフレームの作成
df_crab <- data.frame(
  sex = c("male", "male", "male", "female", "female", "female"),
  shell_width    = c(13.8, 14.3, 14.1, 6.8, 7.2, 6.5),
  scissors_width = c( 2.8,  3.2,  3.1, 1.8, 2.3, 2.1)
)


## 標準設定のままでファイル出力

# CSVファイル出力：余計なものがいろいろとつく
write.csv(
  x = df_crab,
  file = "crab.csv"
)


## 行番号とダブルクォーテーションマークをなくして出力

# CSVファイル出力：シンプルな形
write.csv(
  x = df_crab,
  file = "crab_2.csv",
  quote = FALSE,
  row.names = FALSE
)


# テキストファイルの読み書き -----------------------------------------------------------

## テキストファイルの書き出し

# ファイルへの書き込み
f <- file("report.txt", "w")

# 文字を書き込む
writeLines(
  text = "# this  file is result of exam.", 
  con = f
)

# ファイルを閉じる
close(f)


## テキストファイルの読み込み

# ファイルの中身を読み込む
f <- file("report.txt", "r")
readLines(f)
close(f)

# ファイル名を指定しても良い
readLines("report.txt")


## scan関数によるファイル全体の読み込み

# scanを用いた読み込み
scan("report.txt", what = "", sep = ",")

# CSVファイルを読み込む
file_data <- scan("2-1-1-height.csv", what = "", sep = ",")
file_data
class(file_data)


# memo：read.table関数の中身
read.table


# pasteとsprintfによる文字列の結合 --------------------------------------------------

## paste関数による文字列の結合

# 得点が記録された変数
point_taro <- 80
point_hanako <- 100

# 見やすい形式で表示
paste("score:Taro is ", point_taro, sep = "")
paste("score:Hanako is ", point_hanako, sep = "")


## sprintf関数による文字列の結合

# フォーマットを指定して結合
sprintf("score:Taro is %s point", point_taro)


# ファイルへ整形された文字列を出力する -------------------------------------------------------

# ファイルへの書き込み。追記
f <- file("report.txt", "a")

# 文字を書き込む
writeLines(
  text = sprintf("score:%7s is %3d point", "Taro", 80),
  con = f
)
writeLines(
  text = sprintf("score:%7s is %3d point", "Hanako", 100),
  con = f
)
# ファイルを閉じる
close(f)

# ファイルの中身を読み込む
readLines("report.txt")

# 参考
?sprintf

