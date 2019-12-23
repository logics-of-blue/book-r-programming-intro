
# データ分析を体験する|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# 単回帰分析 -------------------------------------------------------------------

data_height <- read.csv("2-1-1-height.csv")
mod_lm <- lm(children ~ parents, data = data_height)
summary(mod_lm)

