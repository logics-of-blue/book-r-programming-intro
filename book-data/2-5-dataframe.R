
# データフレーム|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# 整然データとはなにか -------------------------------------------------------------------

# 整然データではないデータ
vec_dame <- c("オス：13.8cm", "オス：14.3cm", "メス：6.8cm")


# データフレームの作成 --------------------------------------------------------------

# データフレームの作成
df_crab <- data.frame(
  sex = c("male", "male", "male", "female", "female", "female"),
  shell_width    = c(13.8, 14.3, 14.1, 6.8, 7.2, 6.5),
  scissors_width = c( 2.8,  3.2,  3.1, 1.8, 2.3, 2.1)
)

# 確認
df_crab


# memo：rep関数を使う
# 参考：rep関数を使う
rep(c("male", "female"), each = 3)


# 整然データと雑然データ -------------------------------------------------------------

# 整然データではないデータ
df_crab_dame <- data.frame(
  male_shell      = c(13.8, 14.3, 14.1),
  female_shell    = c( 6.8,  7.2,  6.5),
  male_scissors   = c( 2.8,  3.2,  3.1),
  female_scissors = c( 1.8,  2.3,  2.1)
)

# 確認
df_crab_dame


# $記号を使った列の取得 ------------------------------------------------------------

# $記号を使って性別の列のみを取得
df_crab$sex

# 甲羅の大きさのみ
df_crab$shell_width
df_crab$shell

# ハサミの幅のみ
df_crab$sc


# データフレームの個別の要素の取得 -----------------------------------------------------------------

## 二重角カッコを使った列の取得

# 列番号を指定
df_crab[[1]]

# 性別のみ
df_crab[["sex"]]


## 一重角カッコを使った列の取得

# 角カッコを使う
df_crab[, 1]

# 角カッコに列名を指定する
df_crab[, "sex"]

# 角カッコに列名のベクトルを指定する
df_crab[, c("sex", "shell_width")]

# 列番号のベクトルを指定
df_crab[, c(1, 2)]


## 行と列の両方を指定した要素の取得

# 行列ともに指定
df_crab$scissors_width[2]
df_crab[2, "scissors_width"]


# memo：抽出結果をdata.frameにする
# 抽出結果はfactorのベクトル
df_crab[, 1]
class(df_crab[, 1])
# 抽出結果をdata.frameにする
df_crab[, 1, drop = FALSE]
class(df_crab[, 1, drop = FALSE])


# headとtailによる先頭行と末尾行の抽出 ------------------------------------------------

# 先頭行の取り出し
head(df_crab, n = 2)

# 末尾行の取り出し
tail(df_crab, n = 2)


# subsetによる条件を用いたデータの抽出 ---------------------------------------------------

# 性別がmaleのデータだけを抽出する
subset(df_crab, subset = df_crab$sex == "male")


# nrow・ncol・dimによる行数と列数の取得 ----------------------------------------------------

# 行数の取得
nrow(df_crab)

# 列数の取得
ncol(df_crab)

# 行数と列数を両方出力
dim(df_crab)


# データフレームにおける文字列の扱い -------------------------------------------------------

# 通常の作成方法だと、文字列はfactorになっている
class(df_crab$sex)


## データを作成する際に、factorになるのを防ぐ

# factorにしない
df_crab_char <- data.frame(
  sex = c("male", "male", "male", "female", "female", "female"),
  shell_width    = c(13.8, 14.3, 14.1, 6.8, 7.2, 6.5),
  scissors_width = c( 2.8,  3.2,  3.1, 1.8, 2.3, 2.1),
  stringsAsFactors = FALSE
)

# characterに戻った
class(df_crab_char$sex)

# sex列を確認
df_crab_char$sex


## データを読み込んだ後に、データ型を変換する

# 変換：factorからcharacterへ
as.character(df_crab$sex)

# 変換：characterからfactorへ
as.factor(df_crab_char$sex)

# 変換結果を格納
df_crab_char$sex <- as.factor(df_crab_char$sex)

# factor型に変換された
class(df_crab_char$sex)


# str関数によるデータフレームの構造の確認 ---------------------------------------------------

# データフレームの構造の確認
str(df_crab)


# names関数による列名の取得 --------------------------------------------------------

# 要素名の取得
names(df_crab)

# 列名の取得
colnames(df_crab)



