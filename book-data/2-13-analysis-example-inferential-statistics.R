
# 3行以下で終わる分析の例：推測統計編|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# 母比率の検定：二項検定 --------------------------------------------------------------------

# 10回コインを投げて、8回が表だった
# このコインはイカサマコインとみなせるか
# 母比率の検定：二項検定
# 片側検定(上側)
binom.test(x = 8, n = 10, alternative = "greater")


# memo：片側検定・両側検定
# 参考：片側検定(下側)
binom.test(x = 8, n = 10, alternative = "less")
# 両側検定
binom.test(x = 8, n = 10, alternative = "two.sided")


# memo：binom.testを使わないでp値を計算する
x <- 8
n <- 10
p <- 0.5
# 片側検定(上側)
sum(dbinom(x = x:n, size = n, prob = p))


# memo：基準となる確率を変える
binom.test(x = 8, n = 10, p = 0.4, alternative = "greater")


# 分割表の検定：χ二乗検定 -------------------------------------------------------------------

# 分割表の検定：χ二乗検定
fish_chicken <- read.csv("2-9-5-fish-chicken.csv")
t_fish_chicken <- table(fish_chicken)
chisq.test(t_fish_chicken, correct = FALSE)


# memo：クロス集計表の復習
table(fish_chicken)


# memo：3カテゴリに対する検定
favorite_food <- read.csv("2-9-6-favorite-food.csv")
t_favorite_food <- table(favorite_food)
t_favorite_food
chisq.test(t_favorite_food, correct = FALSE)


# 1群の平均値に対する検定：1変量のt検定 -----------------------------------------------------------------

# 1群の平均値に対する検定：1変量のt検定
parts_weight <- read.csv("2-13-1-parts-weight.csv")
head(parts_weight, n = 3)
t.test(x = parts_weight$parts_weight, mu = 10)


# 2群の平均値の差の検定：（対応のある）t検定 --------------------------------------------------

# 2群の平均値の差の検定：（対応のある）t検定
aft_training <- read.csv("2-13-2-bef-training.csv")
bef_training <- read.csv("2-13-3-aft-training.csv")
t.test(bef_training$time, aft_training$time, paired = TRUE)


# memo：データの確認
aft_training
bef_training


# memo：1変量のt検定と、対応のあるt検定の比較
diff_time <- bef_training$time - aft_training$time
t.test(diff_time, mu = 0)


# 2群の平均値の差の検定：（対応のない）t検定 --------------------------------------------------

# 2群の平均値の差の検定：（対応のない）t検定
two_machine <- read.csv("2-13-4-two-machine.csv")
head(two_machine, n = 3)
t.test(formula = weight ~ type, data = two_machine)


# memo：データの確認
tapply(two_machine$weight, two_machine$type, summary)


# 2群の中央値の差の検定：Wilcoxonの検定 ---------------------------------------------------------

# 2群の中央値の差の検定：Wilcoxonの検定
two_machine <- read.csv("2-13-4-two-machine.csv")
wilcox.test(formula = weight ~ type, data = two_machine)


# 3群以上の差の検定：1元配置分散分析 ------------------------------------------------------

# 3群以上の差の検定：1元配置分散分析
three_machine <- read.csv("2-13-5-three-machine.csv")
mod_lm <- lm(weight ~ type, data = three_machine)
anova(mod_lm)


# memo：aov関数を使う方法
mod_aov <- aov(weight ~ type, data = three_machine)
summary(mod_aov)


# memo：データの確認
# データの先頭の3行を確認
head(three_machine, n = 3)
# 装置ごとの生産部品の要約統計量
tapply(three_machine$weight, three_machine$type, summary)


# memo：箱ひげ図の描画
boxplot(weight ~ type, data = three_machine)
 

# 3群以上の差の検定：クラスカル・ウォリス検定 ------------------------------------------------------

# 3群以上の差の検定：クラスカル・ウォリス検定
three_machine <- read.csv("2-13-5-three-machine.csv")
kruskal.test(weight ~ type, data = three_machine)


# 多重比較法 ------------------------------------------------------------------

# 多重比較法
three_machine <- read.csv("2-13-5-three-machine.csv")
pairwise.t.test(three_machine$weight, three_machine$type,
                p.adj = "bonferroni")


# 参考：ボンフェローニの方法以外の方法を使う場合はヘルプを参照
?pairwise.t.test


# 相関係数とその検定 ----------------------------------------------------------

# 相関係数とその検定
sales_population <- read.csv("2-9-3-sales-population.csv")
cor.test(x = sales_population$beef, 
         y = sales_population$resident_population)


# memo：相関行列の計算
cor(sales_population)


# memo：ノンパラメトリックな順位相関係数の検定
# スピアマンの順位相関係数の検定
cor.test(x = sales_population$beef, 
         y = sales_population$resident_population,
         method = "spearman")
# ケンドールの順位相関係数の検定
cor.test(x = sales_population$beef, 
         y = sales_population$resident_population,
         method = "kendall")

