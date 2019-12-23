
# データの整形と結合|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# ライブラリの読み込み --------------------------------------------------------------

library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)


# 縦持ちデータと横持ちデータ -----------------------------------------------------------

## 縦持ちデータの例

# 縦持ちデータ
tidy_1 <- read_csv("4-7-1-tidy-data-1.csv")
tidy_1


## 横持ちデータの例

# 横持ちデータ
messy_1 <- read_csv("4-7-2-messy-data-1.csv")
messy_1


## 縦持ちデータの分析事例

# 縦持ちデータはデータの可視化が容易
ggplot(data = tidy_1) +
  geom_line(aes(x = time, y = sales, colour = product)) + 
  ylim(0, 40) +
  scale_x_date(date_labels = "%m月%d日")


# 横持ちデータ→縦持ちデータの変換 ------------------------------------------------------------------

## pivot_longer関数の適応例

# pivot_longerの適用
messy_1 %>% 
  pivot_longer(cols = c(product_a, product_b, product_c),
               names_to = "product", values_to = "sales")

# pivot_longerした結果を可視化
messy_1 %>% 
  pivot_longer(cols = c(product_a, product_b, product_c),
               names_to = "product", values_to = "sales") %>% 
  ggplot() +
  geom_line(aes(x = time, y = sales, colour = product)) + 
  ylim(0, 40) +
  scale_x_date(date_labels = "%m月%d日")


## pivot_longer関数の使い方：names_toとvalues_toの指定

# names_to, values_toはあくまでも列の名称にすぎない
messy_1 %>% 
  pivot_longer(cols = c(product_a, product_b, product_c),
               names_to = "name_1", values_to = "name_2")


## pivot_longer関数の使い方：集約される列名の指定

# 指定されなかった列は、そのまま残る
messy_1 %>% 
  pivot_longer(cols = c(product_a, product_b),
               names_to = "product", values_to = "sales")

# 集約させたくない列のみを、マイナス記号で指定する
messy_1 %>% 
  pivot_longer(cols = -time,
               names_to = "product", values_to = "sales")


# 縦持ちデータ→横持ちデータの変換 ------------------------------------------------------------------

# 対象のデータ
tidy_1

# pivot_widerの適用
tidy_1 %>% 
  pivot_wider(names_from = "product", values_from = "sales")


# memo：gather関数とspread関数
# gather
messy_1 %>% 
  gather(key = "product", value = "sales", 
         product_a, product_b, product_c)
# spread
tidy_1 %>% 
  spread(key = "product", value = "sales")


# 列の分割と結合 -------------------------------------------------

## 「1つのセルに2つ以上のデータが含まれる」データの例

# 対象のデータ
messy_2 <- read_csv("4-7-3-messy-data-2.csv")

# 「1つのセルに2つ以上のデータが含まれる」データ
messy_2


## separate関数による列の分割

# 2列に分ける
tidy_2 <- messy_2 %>% 
  separate(col = data, into = c("sex", "shell_width"), 
           sep = "：", convert = TRUE)
tidy_2


## unite関数による列の結合

# 2列を結合する
tidy_2 %>% 
  unite(sex, shell_width, col = "unite", sep = "/")


# inner_joinによる結合 --------------------------------------------------------------

## データの読み込み

# 対象のデータ
tbl_sales <- read_csv("4-7-4-tbl-sales.csv")
tbl_product <- read_csv("4-7-5-tbl-product.csv")

# 結合の対象となるテーブル
# 毎日の売り上げデータ
tbl_sales
# 商品情報
tbl_product


## inner_join関数によるテーブルの結合

# inner_join関数の適用
tbl_sales %>% 
  inner_join(tbl_product, by = c("product_id" = "id"))

# 飲み物と食べ物で売上個数・金額の2日間平均値を得る
tbl_sales %>% 
  inner_join(tbl_product, by = c("product_id" = "id")) %>% 
  group_by(category) %>% 
  summarise(mean_sales_quantity = mean(sales_quantity),
            mean_sales_price = mean(sales_quantity * price))


# left_joinとright_joinによる結合 ----------------------------------------------------

## left_join関数によるテーブルの結合

# left_join関数の適用
tbl_sales %>% 
  left_join(tbl_product, by = c("product_id" = "id"))


## right_join関数によるテーブルの結合

# right_join関数の適用
tbl_sales %>% 
  right_join(tbl_product, by = c("product_id" = "id"))


# full_joinによる結合 ---------------------------------------------------------------

# full_join関数の適用
tbl_sales %>% 
  full_join(tbl_product, by = c("product_id" = "id"))


# 3つのテーブルを結合させる分析事例 --------------------------------------------------------------------

## データの読み込み

# 対象のデータ
mst_sales <- read_csv("4-7-6-mst-sales.csv")
mst_shop <- read_csv("4-7-7-mst-shop.csv")
mst_product <- read_csv("4-7-8-mst-product.csv")

# 売上データ
mst_sales

# 店舗情報
mst_shop

# 商品情報
mst_product


## テーブルの結合

# 結合
join_data <- mst_sales %>% 
  left_join(mst_shop, by = c("shop_id" = "id")) %>% 
  left_join(mst_product, by = c("product_id" = "id")) %>% 
  rename(product=name) %>% 
  select(-product_id)

# 確認
join_data

# 有効数字を5桁に増やす
options(pillar.sigfig = 5)


## 最も売れている商品を調べる

# 最も売れている商品は(個数)
join_data %>% 
  group_by(product) %>% 
  summarise(sum_sales = sum(sales)) %>% 
  arrange(desc(sum_sales))

# 最も売れている商品は(金額：万円)
join_data %>% 
  group_by(product) %>% 
  summarise(sum_prices = sum(sales * price / 10000)) %>% 
  arrange(desc(sum_prices))


## 最も売れている店舗を調べる

# 最も売れているお店は(金額：万円)
join_data %>% 
  group_by(shop_id) %>% 
  summarise(sum_prices = sum(sales * price / 10000)) %>% 
  arrange(desc(sum_prices))


## 商品別・男女別・地域別の売上集計

# 商品別・男女別・地域別の売上集計地の棒グラフを描く
join_data %>% 
  group_by(product, sex, region) %>% 
  summarise(sales = sum(sales * price / 10000)) %>% 
  ggplot() + 
  geom_col(aes(x = product, y = sales, fill = sex), 
           position = "dodge") +
  facet_grid( ~ region) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


