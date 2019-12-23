
# 様々なデータ構造の使い分け|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# リストの作成 ------------------------------------------------------------------

# リストの作成
list_college_member <- list(
  school_year = 2,
  member = c("Taro", "Hanako")
)

# 確認
list_college_member


# 様々なリスト ------------------------------------------------------------------

# 複雑なリスト
list_complexly <- list(
  mark = data.frame(member = c("Taro", "Hanako"), 
                    point = c(75, 86)),
  member = list_college_member
)

# 確認
list_complexly


# リストの個別の要素の取得 ------------------------------------------------------------

# 学年のみを取得
list_college_member$school_year

# メンバーだけを取得
list_college_member$member

#  要素番号を指定する
list_college_member[[2]]

# names関数やstr関数も適用できる
names(list_college_member)
str(list_college_member)


# データフレームとリストの関係 ----------------------------------------------------------

# リストかどうかの判断
is.list(list_college_member)

# データフレームの作成
df_sample <- data.frame(
  member = c("Taro", "Hanako"),
  point = c(75, 86)
)
df_sample

# リストかどうかの判断
is.list(df_sample)


# 行列→ベクトルの変換 --------------------------------------------------------------

# 変換対象となる行列
mat_1 <- matrix(1:6, ncol=2)

# 確認
mat_1

# ベクトルに変換
vec_by_mat <- as.vector(mat_1)

# 確認
vec_by_mat


# データフレーム→行列の変換 -----------------------------------------------------------

# 変換対象となるデータフレーム
df_1 <- data.frame(
  col_1 = c(1, 3, 8),
  col_2 = c(5, 7, 9)
)

# 確認
df_1

# 変換
mat_by_df <- as.matrix(df_1)
mat_by_df

# 確認
class(mat_by_df)


# 行列→データフレームの変換 -----------------------------------------------------------

# 変換
df_by_mat <- as.data.frame(mat_by_df)
df_by_mat

# 確認
class(df_by_mat)


# リスト→ベクトルの変換 -------------------------------------------------------------

# リストの中身をベクトルにして出力
unlist(list_college_member)

