
# データの可視化|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# パッケージの読み込み --------------------------------------------------------------

library(readr)
library(dplyr)
library(ggplot2)


# ヒストグラム ---------------------------------------------------------

# 対象のデータ
sales_beef <- read_csv("2-9-1-sales-beef.csv")
sales_beef %>% print(n = 3)

# ヒストグラム
ggplot(data = sales_beef) + 
  geom_histogram(mapping = aes(x = beef),
                 bins = 3, alpha = 0.7, colour = "black") 


# グラフタイトルなどの追加 ------------------------------------------------------------

# 装飾をつける
ggplot(data = sales_beef) + 
  geom_histogram(mapping = aes(x = beef),
                 bins = 3, alpha = 0.7, colour = "black") +
  labs(title = "グラフのメインタイトル", 
       subtitle = "グラフのサブタイトル") +
  xlab("X軸ラベル") +
  ylab("Y軸ラベル")


# カーネル密度推定 ----------------------------------------------------------------

# カーネル密度推定
ggplot(data = sales_beef) + 
  geom_density(mapping = aes(x = beef),
               alpha = 0.2, fill = "black") 

# 棒グラフ --------------------------------------------------------------------

# 対象のデータ
sales_beef_region <- read_csv("2-9-2-sales_beef_region.csv")
sales_beef_region %>% print(n = 3)

# 棒グラフ
ggplot(data = sales_beef_region) +
  geom_bar(mapping = aes(x = region, y = beef),
           stat = "identity")

# geom_colでも良い
ggplot(data = sales_beef_region) +
  geom_col(mapping = aes(x = region, y = beef))


# 集計値に対する棒グラフ -------------------------------------------------------------

# 対象のデータ
sales_meat <- read_csv(
  "2-9-4-sales-meat.csv", 
  col_types = cols(category = col_factor()))
sales_meat %>% print(n = 3)

# 集計処理の後にggplot関数を適用
# 集計
summarise_meat <- sales_meat %>% 
  group_by(category) %>% 
  summarise(sales = mean(sales))
summarise_meat

# 可視化
ggplot(summarise_meat) +
  geom_col(mapping = aes(x = category, y = sales))
  
# geom_bar内部で集計する
ggplot(data = sales_meat) +
  geom_bar(mapping = aes(x = category, y = sales),
           stat = "summary", fun.y = "mean")

# 参考：そのほかの集計値
ggplot(data = sales_meat) +
  geom_bar(mapping = aes(x = category, y = sales),
           stat = "summary", fun.y = "max")


# 2つ以上のグループを対象とした集計値に対する棒グラフ ----------------------------------------------

# 対象のデータ
warpbreaks %>% head(n = 3)

# 集計
summarise_warpbreaks <- warpbreaks %>% 
  group_by(wool, tension) %>% 
  summarise(breaks = mean(breaks))
summarise_warpbreaks

# 可視化
ggplot(summarise_warpbreaks) +
  geom_col(mapping = aes(x = wool, fill = tension, y = breaks),
           position = "dodge")

# 参考：積み上げ棒グラフ
ggplot(summarise_warpbreaks) +
  geom_col(mapping = aes(x = wool, fill = tension, y = breaks),
             position = "stack")

# geom_bar内部で集計する
ggplot(data = warpbreaks) +
  geom_bar(mapping = aes(x = wool, fill = tension, y = breaks),
           stat = "summary", fun.y = "mean", position = "dodge")


# memo：グループ分けの考え方
ggplot(data = warpbreaks) +
  geom_bar(aes(x = wool, group = tension, y = breaks),
           stat = "summary", fun.y = "mean", position = "dodge")


# memo：stat_summaryの使用
ggplot(data = warpbreaks) +
  stat_summary(aes(x = wool, fill = tension, y = breaks),
               geom = "bar", fun.y = "mean", 
               position = "dodge")


# memo：エラーバーの追加
ggplot(data = warpbreaks) +
  stat_summary(aes(x = wool, fill = tension, y = breaks),
               geom = "bar", fun.y = "mean", 
               position = "dodge") +
  stat_summary(aes(x = wool, group = tension, y = breaks),
               geom = "errorbar", width = 0.25,
               fun.data = "mean_se", 
               position = position_dodge(0.9))


# 箱ひげ図とグラフ領域の指定 --------------------------------------------------------------------

# 2つ以上のカテゴリを対象とした箱ひげ図
ggplot(data = warpbreaks) +
  geom_boxplot(aes(x = wool, fill = tension, y = breaks)) +
  ylim(0, 75)


# バイオリンプロットとグレースケールへの変更 ---------------------------------------------------------------

# 2つ以上のカテゴリを対象としたバイオリンプロット(グレースケール)
ggplot(data = warpbreaks) +
  geom_violin(aes(x = wool, fill = tension, y = breaks)) +
  ylim(0, 75) +
  scale_fill_grey()


# グリッドの分割 -----------------------------------------------------------------

# グリッドの分割
ggplot(data = warpbreaks) +
  geom_violin(aes(x = wool, y = breaks)) +
  facet_grid(~ tension) + 
  ylim(0, 75)


# 散布図 ---------------------------------------------------------------------

# 対象のデータ
iris %>% head(n = 3)

# 色分けした散布図。テーマはクラシック
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, 
                 colour = Species)) + 
  theme_classic()

# 参考：テーマの変更
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, 
                 colour = Species)) + 
  theme_bw()

# 参考：文字サイズの変更
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, 
                 colour = Species)) + 
  theme_gray(base_size = 20)


# 折れ線グラフと軸ラベルの設定 ------------------------------------------------------------------

# 対象のデータ
tbl_day_time <- read_csv("4-5-2-ts-day-time.csv")
tbl_day_time

# 折れ線グラフ
ggplot(data = tbl_day_time) +
  geom_line(mapping = aes(x = time, y = sales)) +
  scale_x_datetime(date_labels = "%Y/%m/%d \n %H:%M:%S")


# qplotを使った簡易的な実装 ---------------------------------------------------------

# 棒グラフ
qplot(x = region, y = beef,
      data = sales_beef_region, geom = "col")

# 折れ線グラフ
qplot(x = time, y = sales, 
      data = tbl_day_time, geom = "line") +
  scale_x_datetime(date_labels = "%Y/%m/%d \n %H:%M:%S")

# 参考：ヒストグラム
qplot(x = beef, 
      data = sales_beef, geom = "histogram", 
      bins = 3, alpha = I(0.7), colour = I("black"))

# 参考：箱ひげ図
qplot(x = wool, fill = tension, y = breaks, 
      data = warpbreaks, geom = "boxplot")

# 参考：バイオリンプロット
qplot(x = wool, fill = tension, y = breaks, 
      data = warpbreaks, geom = "violin")

# 参考：散布図
qplot(x = Sepal.Length, y = Sepal.Width, color = Species, 
      data = iris, geom = "point")


# グラフのファイル出力 ----------------------------------------------

# 最後に出力したグラフを画像にする
ggsave("plot.png", width = 5, height = 5)

# 参考：SVGファイル出力
svg(
  filename = "result.svg",
  width = 6,
  height = 4,
  family="MS Gothic"
)
qplot(x = time, y = sales, 
      data = tbl_day_time, geom = "line") +
  scale_x_datetime(date_labels = "%Y/%m/%d \n %H:%M:%S")
dev.off()


# ggplot2の拡張 --------------------------------------------------------------

# 散布図行列を描く
library(GGally)
ggpairs(data = iris, mapping = aes(colour = Species))


