
# データの型|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# データの型の判断とclass関数 --------------------------------------------------------

# データの型の確認
class(2)


# 数値：numericとinteger ------------------------------------------------------

# 整数型
class(2L)


# 論理値型 --------------------------------------------------------------------

# 論理値型
class(TRUE)
class(FALSE)


# memo：TRUEやFALSEの省略形
# 省略形
T
F

# 中身の書き換え
T <- 930
# Tの中身の確認
T
# Tのデータ型の確認
class(T)


# 文字列型 --------------------------------------------------------------------

# 文字列型
class("A")


# ファクター -------------------------------------------------------------------

# ファクター
class(factor("A"))

# 参考：数値をfactorにする
factor(1)


# 欠損など ----------------------------------------------------------------

## NA

# NA：あるべきデータがそこにない
NA

## NULL

# NULL：空である
NULL

## NaN

# 計算できない
NaN

0 / 0

## Inf

# 無限
Inf

1 / 0


# データの型の変換 ----------------------------------------------------------------

## データ型の変換の基本

# 数値
num <- 1
class(num)

# factorに変換
num_to_fac <- as.factor(num)
class(num_to_fac)

# 参考：関数一覧
class(as.numeric("2"))  # 数値に変換
class(as.integer(2))    # 整数に変換
class(as.logical(2))    # 論理値型に変換
class(as.character(2))  # characterに変換
class(as.factor(2))     # factorに変換


## numericとlogicalの変換

# numeric→logical
as.logical(0)
as.logical(1)
as.logical(2)

# logical→numeric
as.numeric(FALSE)
as.numeric(TRUE)


# データの型のチェック --------------------------------------------------------------

# numericかどうかのチェック
num <- TRUE
is.numeric(num)

# 論理値型への足し算
num <- TRUE
num + 5

# 参考：関数一覧
is.numeric(1)    # 数値判定
is.integer(1)    # 整数判定
is.logical(1)    # 論理値判定
is.character(1)  # 文字列判定
is.factor(1)     # factor判定
is.na(1)         # NA判定
is.null(1)       # NULL判定
is.nan(1)        # Nan判定
is.infinite(1)   # Inf判定


