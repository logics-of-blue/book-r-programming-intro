
# 日付の操作|R言語ではじめるプログラミングとデータ分析
# 馬場真哉


# パッケージの読み込み --------------------------------------------------------------

library(readr)
library(lubridate)
library(hms)


# 基本のts型 ------------------------------------------------------------------

## ts型データの作成

# 1年に1回取得されるデータ
ts_year <- ts(1:5, start = 2001, freq = 1)
ts_year

# 1年に4回取得されるデータ
ts_quarter <- ts(1:5, start = c(2001, 1), freq = 4)
ts_quarter

# 1年に12回取得されるデータ
ts_month <- ts(1:5, start = c(2001, 1), freq = 12)
ts_month

# 1年に365.25回(うるう年を加味)取得されるデータ
ts_day <- ts(1:5, start = c(2000, 1), freq = 365.25)
ts_day


## 多変量時系列データの作成

# 多変量時系列データ
sales_df <- data.frame(
  beef = c(10, 23, 24, 30),
  pork = c( 8, 13, 19, 20)
)

ts(sales_df, start = c(2001, 1), freq = 12)


# Date型による日付の操作 -----------------------------------------------------------

## Date型データの作成

# ただの文字列
date_chr <- "2001-01-12"
class(date_chr)

# Date型の日付
date_asDate <- as.Date("2001-01-12")
date_asDate
class(date_asDate)


# memo：日付を数値に変換
# 日付を数値に変換
as.numeric(date_asDate)


## 日付の連番の取得

# 1日単位の日付
seq(from = as.Date("2000-01-01"), 
    to = as.Date("2000-01-04"),
    by = "days")

# 引数にlenを使う
seq(from = as.Date("2000-01-01"), 
    len = 4,
    by = "days")

# 参考：1週単位の日付
seq(from = as.Date("2000-01-01"), 
    len = 4,
    by = "weeks")

# 参考：月単位の日付
seq(from = as.Date("2000-01-01"), 
    len = 4,
    by = "months")

# 参考：年単位の日付
seq(from = as.Date("2000-01-01"), 
    len = 4,
    by = "years")


## Date型のデータに対する演算

# 46日後の日付
date_asDate + 46

# 2001年3月1日までの日数
diff_day <- as.Date("2001-03-01") - date_asDate
diff_day


## 日付の差分とdifftime型

# difftimeクラスになっている
class(diff_day)


# POSIXltとPOSIXctによる日時の操作 -------------------------------------------------

# POSIXlt型とPOSIXct型データの作成

# POSIXct
datetime_asct <- as.POSIXct("2019-02-03 10:20:05")
datetime_asct

# POSIXlt
datetime_aslt <- as.POSIXlt("2019-02-03 10:20:05")
datetime_aslt


# memo：日時を数値に変換
# 日時を数値に変換
ct_1970 <- as.POSIXct("1970-01-01 00:00:05", tz = "UTC")
as.numeric(ct_1970)
# 1970年1月1日0時0分0秒からの秒数が格納されている
ct_1970 - as.POSIXct("1970-01-01 00:00:00", tz = "UTC")


## POSIXltとPOSIXctの違い

# POSIXltはリスト
is.list(datetime_asct)
is.list(datetime_aslt)

# as.POSIXltだと、要素の抽出が容易
# ただし、後ほど登場するlubridateを使った方が楽
datetime_aslt$year
datetime_aslt$mon


## タイムゾーン

# タイムゾーンの変更
tokyo <- as.POSIXct("2019-02-03 10:20:05", tz = "Asia/Tokyo")
utc <-   as.POSIXct("2019-02-03 10:20:05", tz = "UTC")
tokyo
utc

# 時差
utc - tokyo

# 参考：タイムゾーン一覧
OlsonNames()


# lubridateパッケージによる日時データの作成 --------------------------------------------------

## 文字列を日時データに変換する

# as.Dateやas.POSIXctは、変換が意外と難しい
# 下記はエラー
as.Date("20010112")
as.POSIXct("20190203102005")

# lubridateのymd_hmsを使うと、変換が簡単になる
# 日時データのtimeZoneは標準だとUTCになってしまうので注意
date_ymd <- ymd("20010112")
datetime_ymd_hms <- ymd_hms("20190204102005", 
                            tz = "Asia/Tokyo")

date_ymd
datetime_ymd_hms

# 参考：様々な関数が用意されている
?ymd_hms

# データの型はDateやPOSIXct
class(date_ymd)
class(datetime_ymd_hms)


## 個別の日時情報から作成する

# 日付の作成
make_date(year = 2000, month = 3, day = 20)

# 日時の作成
make_datetime(year = 2000, month = 3, day = 20,
              hour = 5, min = 20, sec = 15,
              tz = "Asia/Tokyo")


## 現在日や現在の日時の取得

# 現在日の取得
today()

# 現在の日時の取得
now()

# 参考：データの型はDateやPOSIXct
class(today())
class(now())


# lubridateを使った日時の情報の取得と変更 ---------------------------------------------------

## 日時情報の取得

# 対象となる日時
datetime_ymd_hms

# lubridateパッケージには、
# 時間の情報を取得する関数が豊富に用意されている
year(datetime_ymd_hms)   # 年
month(datetime_ymd_hms)  # 月
day(datetime_ymd_hms)    # 日
hour(datetime_ymd_hms)   # 時
minute(datetime_ymd_hms) # 分
second(datetime_ymd_hms) # 秒

# 1月1日からみて何日目か
yday(datetime_ymd_hms)

# 1月1日からみて何週目か
week(datetime_ymd_hms)

# 曜日
wday(datetime_ymd_hms)
wday(datetime_ymd_hms, label = TRUE)
wday(datetime_ymd_hms, label = TRUE, abbr = FALSE)

# 四半期
quarter(datetime_ymd_hms)

# 日付のみ取得
date(datetime_ymd_hms)
class(date(datetime_ymd_hms))


## 日時の情報の変更

# 特定の要素のみを変更することも可能
# 変更前
datetime_ymd_hms

# 59分に変更
minute(datetime_ymd_hms) <- 59

# 変更後
datetime_ymd_hms


# hmsを使った時間の操作 ------------------------------------------------------------

## 時間のデータの作成

# 「秒/分/時」のデータの作成
time_hms <- hms::hms(second = 10, minute = 23, hours = 5)
time_hms
class(time_hms)

# 参考：引数の名称の省略。順番に注意
hms::hms(10, 23, 5)

# 参考：lubridateパッケージのhms関数では正しく動作しないので注意
lubridate::hms(10, 23, 5)

# 文字列から変換
hms::parse_hms("05:23:10")


## 時間の情報の取得

# 時・分・秒の取得
lubridate::hour(time_hms)
lubridate::minute(time_hms)
lubridate::second(time_hms)

# 秒数に変換
as.numeric(time_hms)

# 秒数からhmsに変換する
hms::hms(19390)


## hms型データに対する演算

# マラソンにかかった時間
my_running_time  <- hms::hms(10, 54, 1)
his_running_time <- hms::hms(15, 8, 2)
my_running_time
his_running_time

# かかった時間の差
diff_running_time <- his_running_time - my_running_time
diff_running_time
class(diff_running_time)

# hmsとして扱う
hms::as_hms(diff_running_time)


# 日時データの読み込み ----------------------------------------------------------------

## データを読み込む際に、データ型を変換する

# 日付データの読み込み
tbl_day <- read_csv("4-5-1-ts-day.csv")
tbl_day
class(tbl_day$time)

# 日時データの読み込み
tbl_date_time_1 <- read_csv("4-5-2-ts-day-time.csv",
                            locale = locale(tz = "Asia/Tokyo"))
tbl_date_time_1
tbl_date_time_1$time
class(tbl_date_time_1$time)


## formatを指定して日付を読み込む

# 日付を数値として読み込んでしまう
tbl_date_time_2 <- read_csv("4-5-3-ts-day-time-2.csv")

# 参考：time列が数値になっている
tbl_date_time_2

# col_datetimeを使い、formatを指定すれば大丈夫
tbl_date_time_3 <- read_csv(
  "4-5-3-ts-day-time-2.csv",
  col_types = cols(time = col_datetime(format = "%Y%m%d%H%M%S")),
  locale = locale(tz = "Asia/Tokyo")
)
tbl_date_time_3
class(tbl_date_time_3$time)

# 参考
read_csv("4-5-2-ts-day-time.csv",
         col_types = cols(time = col_datetime(format = "%Y-%m-%d %H:%M:%S")),
         locale = locale(tz = "Asia/Tokyo"))



## tibbleに対してデータ型を変換する

# 日付に変換
tbl_date_time_2$time <- parse_date_time(tbl_date_time_2$time, 
                                        orders = "ymdHMS",
                                        tz = "Asia/Tokyo")
tbl_date_time_2
class(tbl_date_time_2$time)


# 日時を含むデータの抽出と集計 ----------------------------------------------------------

## 分析の準備

# ライブラリの読み込み
library(dplyr)

# データの作成
target <- tibble(
  time = seq(from = as.Date("2000-01-01"), 
             to = as.Date("2000-12-31"),
             by = "days"),
  data = 1:366
)
target %>% print(n = 3)


## 日付を活用したデータの抽出

# 特定の日付を抽出
target %>% filter(time == "2000-01-31")

# 日付の範囲を抽出
target %>% filter(time >= "2000-02-01",
                  time <= "2000-02-02")

# between関数を使っても良い
target %>% 
  filter(between(time,
                 ymd("2000-02-01"),ymd("2000-02-02")))

# 第2週のデータを抽出
target %>% filter(week(time) == 2)

# 3月の月曜日を取得
target %>% filter(month(time) == 3,
                  wday(time) == 2)


## 日付を活用した集計

# 4半期ごとの平均値の取得
target %>% 
  mutate(quarter = quarter(time)) %>% 
  group_by(quarter) %>% 
  summarise(mean_Q = mean(data))

# 略した書き方
target %>% 
  group_by(quarter = quarter(time)) %>% 
  summarise(mean_Q = mean(data))


