---
title: "Midterm review and `naniar()`"
date: "2021-02-02"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Identify and manage NA's is data sets where NA's are represented in multiple ways.    
2. Use the `naniar` and `visdat` packages to help manage NA's in large data sets.  

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to HW 6 in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Midterm 1 Review
Let's briefly review the questions from midterm 1 so you can get an idea of how I was thinking about the problems. Remember, there is more than one way to get at these answers, so don't worry if yours looks different than mine!

## Load the libraries

```r
library("tidyverse")
library("janitor")
library("skimr")
```

## Review
When working with outside or "wild" data, dealing with NA's is a fundamental part of the data cleaning or tidying process. Data scientists spend most of their time cleaning and transforming data- including managing NA's. There isn't a single approach that will always work so you need to be careful about using replacements strategies across an entire data set. And, as the data sets become larger NA's can become trickier to deal with.  

For the following, we will use life history data for mammals. The [data](http://esapubs.org/archive/ecol/E084/093/) are from:  
**S. K. Morgan Ernest. 2003. Life history characteristics of placental non-volant mammals. Ecology 84:3402.**  

## Practice
1. Load the mammals life history data and clean the names.  

```r
life_history <- readr::read_csv("data/mammal_lifehistories_v3.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   order = col_character(),
##   family = col_character(),
##   Genus = col_character(),
##   species = col_character(),
##   mass = col_double(),
##   gestation = col_double(),
##   newborn = col_character(),
##   weaning = col_double(),
##   `wean mass` = col_double(),
##   AFR = col_double(),
##   `max. life` = col_double(),
##   `litter size` = col_double(),
##   `litters/year` = col_double()
## )
```

```r
life_history <- janitor::clean_names(life_history)
```

2. Use one or more of the functions from the last lab to determine if there are NA's in the data, how they are represented, and where they are located.

```r
anyNA(life_history)
```

```
## [1] TRUE
```


```r
life_history %>% 
  purrr::map_df(~ sum(is.na(.))) %>% 
  pivot_longer(everything(),
    names_to= "variables",
    values_to = "num_nas") %>% 
  arrange(desc(num_nas))
```

```
## # A tibble: 13 x 2
##    variables    num_nas
##    <chr>          <int>
##  1 litters_year     689
##  2 order              0
##  3 family             0
##  4 genus              0
##  5 species            0
##  6 mass               0
##  7 gestation          0
##  8 newborn            0
##  9 weaning            0
## 10 wean_mass          0
## 11 afr                0
## 12 max_life           0
## 13 litter_size        0
```

```r
life_history %>%
  skimr::skim()
```


Table: Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |Piped data |
|Number of rows           |1440       |
|Number of columns        |13         |
|_______________________  |           |
|Column type frequency:   |           |
|character                |5          |
|numeric                  |8          |
|________________________ |           |
|Group variables          |None       |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|order         |         0|             1|   7|  14|     0|       17|          0|
|family        |         0|             1|   6|  15|     0|       96|          0|
|genus         |         0|             1|   3|  16|     0|      618|          0|
|species       |         0|             1|   3|  17|     0|     1191|          0|
|newborn       |         0|             1|   1|  12|     0|      697|          0|


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|      mean|         sd|      p0|  p25|     p50|     p75|       p100|hist  |
|:-------------|---------:|-------------:|---------:|----------:|-------:|----:|-------:|-------:|----------:|:-----|
|mass          |         0|          1.00| 383576.72| 5055162.92| -999.00|   50|  403.02| 7009.17| 1.4900e+08|▇▁▁▁▁ |
|gestation     |         0|          1.00|   -287.25|     455.36| -999.00| -999|    1.05|    4.50| 2.1460e+01|▃▁▁▁▇ |
|weaning       |         0|          1.00|   -427.17|     496.71| -999.00| -999|    0.73|    2.00| 4.8000e+01|▆▁▁▁▇ |
|wean_mass     |         0|          1.00|  16048.93|  503650.17| -999.00| -999| -999.00|   10.00| 1.9075e+07|▇▁▁▁▁ |
|afr           |         0|          1.00|   -408.12|     504.97| -999.00| -999|    2.50|   15.61| 2.1000e+02|▆▁▁▁▇ |
|max_life      |         0|          1.00|     93.19|     164.81|    0.00|    0|    0.00|  147.25| 1.3680e+03|▇▁▁▁▁ |
|litter_size   |         0|          1.00|    -55.63|     234.88| -999.00|    1|    2.27|    3.84| 1.4180e+01|▁▁▁▁▇ |
|litters_year  |       689|          0.52|      1.64|       1.17|    0.14|    1|    1.00|    2.00| 7.5000e+00|▇▃▁▁▁ |

***The NA's are in the data as -999 and NA***

```r
life_history %>% 
  purrr::map_df(~sum(is.na(.)))
```

```
## # A tibble: 1 x 13
##   order family genus species  mass gestation newborn weaning wean_mass   afr
##   <int>  <int> <int>   <int> <int>     <int>   <int>   <int>     <int> <int>
## 1     0      0     0       0     0         0       0       0         0     0
## # … with 3 more variables: max_life <int>, litter_size <int>,
## #   litters_year <int>
```

3. Can we use a single approach to deal with NA's in this data set? Given what you learned in the previous lab, how would you manage the NA values?


```r
life_history_tidy <- life_history %>% 
  na_if("-999") %>% 
  mutate(newborn=na_if(newborn, ("not measured")))
```

```r
skim(life_history_tidy)
```


Table: Data summary

|                         |                  |
|:------------------------|:-----------------|
|Name                     |life_history_tidy |
|Number of rows           |1440              |
|Number of columns        |13                |
|_______________________  |                  |
|Column type frequency:   |                  |
|character                |5                 |
|numeric                  |8                 |
|________________________ |                  |
|Group variables          |None              |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|order         |         0|          1.00|   7|  14|     0|       17|          0|
|family        |         0|          1.00|   6|  15|     0|       96|          0|
|genus         |         0|          1.00|   3|  16|     0|      618|          0|
|species       |         0|          1.00|   3|  17|     0|     1191|          0|
|newborn       |       595|          0.59|   1|   9|     0|      696|          0|


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|      mean|         sd|   p0|   p25|    p50|     p75|       p100|hist  |
|:-------------|---------:|-------------:|---------:|----------:|----:|-----:|------:|-------:|----------:|:-----|
|mass          |        85|          0.94| 407701.39| 5210474.99| 2.10| 61.15| 606.00| 8554.00| 1.4900e+08|▇▁▁▁▁ |
|gestation     |       418|          0.71|      3.86|       3.62| 0.49|  0.99|   2.11|    6.00| 2.1460e+01|▇▃▁▁▁ |
|weaning       |       619|          0.57|      3.97|       5.38| 0.30|  0.92|   1.69|    4.84| 4.8000e+01|▇▁▁▁▁ |
|wean_mass     |      1039|          0.28|  60220.50|  953857.17| 2.09| 20.15| 102.60| 2000.00| 1.9075e+07|▇▁▁▁▁ |
|afr           |       607|          0.58|     22.44|      26.45| 0.70|  4.50|  12.00|   28.24| 2.1000e+02|▇▁▁▁▁ |
|max_life      |         0|          1.00|     93.19|     164.81| 0.00|  0.00|   0.00|  147.25| 1.3680e+03|▇▁▁▁▁ |
|litter_size   |        84|          0.94|      2.80|       1.77| 1.00|  1.02|   2.50|    4.00| 1.4180e+01|▇▃▁▁▁ |
|litters_year  |       689|          0.52|      1.64|       1.17| 0.14|  1.00|   1.00|    2.00| 7.5000e+00|▇▃▁▁▁ |


## `naniar`
`naniar` is a package that is built to manage NA's. Many of the functions it performs can also be performed using tidyverse functions, but it does provide some interesting alternatives.  

`miss_var_summary` provides a clean summary of NA's across the data frame.

```r
naniar::miss_var_summary(life_history_tidy)
```

```
## # A tibble: 13 x 3
##    variable     n_miss pct_miss
##    <chr>         <int>    <dbl>
##  1 wean_mass      1039    72.2 
##  2 litters_year    689    47.8 
##  3 weaning         619    43.0 
##  4 afr             607    42.2 
##  5 newborn         595    41.3 
##  6 gestation       418    29.0 
##  7 mass             85     5.90
##  8 litter_size      84     5.83
##  9 order             0     0   
## 10 family            0     0   
## 11 genus             0     0   
## 12 species           0     0   
## 13 max_life          0     0
```

Notice that `max_life` has no NA's. Does that make sense in the context of this data?

```r
hist(life_history_tidy$max_life)
```

![](lab7_2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->


```r
life_history_tidy <- 
  life_history_tidy %>% 
  mutate(max_life=na_if(max_life, 0))
```


```r
naniar::miss_var_summary(life_history_tidy)
```

```
## # A tibble: 13 x 3
##    variable     n_miss pct_miss
##    <chr>         <int>    <dbl>
##  1 wean_mass      1039    72.2 
##  2 max_life        841    58.4 
##  3 litters_year    689    47.8 
##  4 weaning         619    43.0 
##  5 afr             607    42.2 
##  6 newborn         595    41.3 
##  7 gestation       418    29.0 
##  8 mass             85     5.90
##  9 litter_size      84     5.83
## 10 order             0     0   
## 11 family            0     0   
## 12 genus             0     0   
## 13 species           0     0
```

We can also use `miss_var_summary` with `group_by()`. This helps us better evaluate where NA's are in the data.

```r
life_history_tidy %>%
  group_by(order) %>%
  select(order, wean_mass) %>% 
  naniar::miss_var_summary(order=T)
```

```
## # A tibble: 17 x 4
## # Groups:   order [17]
##    order          variable  n_miss pct_miss
##    <chr>          <chr>      <int>    <dbl>
##  1 Artiodactyla   wean_mass    134     83.2
##  2 Carnivora      wean_mass    120     60.9
##  3 Cetacea        wean_mass     51     92.7
##  4 Dermoptera     wean_mass      2    100  
##  5 Hyracoidea     wean_mass      3     75  
##  6 Insectivora    wean_mass     67     73.6
##  7 Lagomorpha     wean_mass     28     66.7
##  8 Macroscelidea  wean_mass      8     80  
##  9 Perissodactyla wean_mass     12     80  
## 10 Pholidota      wean_mass      3     42.9
## 11 Primates       wean_mass    108     69.2
## 12 Proboscidea    wean_mass      1     50  
## 13 Rodentia       wean_mass    474     71.3
## 14 Scandentia     wean_mass      5     71.4
## 15 Sirenia        wean_mass      4     80  
## 16 Tubulidentata  wean_mass      0      0  
## 17 Xenarthra      wean_mass     19     95
```

`naniar` also has a nice replace function which will allow you to precisely control which values you want replaced with NA's in each variable.

```r
life_history %>% 
  naniar::replace_with_na(replace = list(newborn = "not measured", weaning= -999, wean_mass= -999, afr= -999, max_life= 0, litter_size= -999, gestation= -999, mass= -999)) %>% 
  naniar::miss_var_summary()
```

```
## # A tibble: 13 x 3
##    variable     n_miss pct_miss
##    <chr>         <int>    <dbl>
##  1 wean_mass      1039    72.2 
##  2 max_life        841    58.4 
##  3 litters_year    689    47.8 
##  4 weaning         619    43.0 
##  5 afr             607    42.2 
##  6 newborn         595    41.3 
##  7 gestation       418    29.0 
##  8 mass             85     5.90
##  9 litter_size      84     5.83
## 10 order             0     0   
## 11 family            0     0   
## 12 genus             0     0   
## 13 species           0     0
```

## Practice
Let's practice evaluating NA's in a large data set. The data are compiled from [CITES](https://cites.org/eng). This is the international organization that tracks trade in endangered wildlife. You can find information about the data [here](https://www.kaggle.com/cites/cites-wildlife-trade-database).  

Some key information:  
[country codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)  

1. Import the data and do a little exploration. Be sure to clean the names if necessary.

```r
cites <- readr::read_csv("data/cites.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Year = col_double(),
##   App. = col_character(),
##   Taxon = col_character(),
##   Class = col_character(),
##   Order = col_character(),
##   Family = col_character(),
##   Genus = col_character(),
##   Importer = col_character(),
##   Exporter = col_character(),
##   Origin = col_character(),
##   `Importer reported quantity` = col_double(),
##   `Exporter reported quantity` = col_double(),
##   Term = col_character(),
##   Unit = col_character(),
##   Purpose = col_character(),
##   Source = col_character()
## )
```

```r
cites <- janitor::clean_names(cites)
```

```r
summary(cites)
```

```
##       year          app               taxon              class          
##  Min.   :2016   Length:67161       Length:67161       Length:67161      
##  1st Qu.:2016   Class :character   Class :character   Class :character  
##  Median :2016   Mode  :character   Mode  :character   Mode  :character  
##  Mean   :2016                                                           
##  3rd Qu.:2016                                                           
##  Max.   :2017                                                           
##                                                                         
##     order              family             genus             importer        
##  Length:67161       Length:67161       Length:67161       Length:67161      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##    exporter            origin          importer_reported_quantity
##  Length:67161       Length:67161       Min.   :       0          
##  Class :character   Class :character   1st Qu.:       3          
##  Mode  :character   Mode  :character   Median :      12          
##                                        Mean   :    4382          
##                                        3rd Qu.:      80          
##                                        Max.   :19524978          
##                                        NA's   :35295             
##  exporter_reported_quantity     term               unit          
##  Min.   :       0           Length:67161       Length:67161      
##  1st Qu.:       2           Class :character   Class :character  
##  Median :      12           Mode  :character   Mode  :character  
##  Mean   :    4444                                                
##  3rd Qu.:      82                                                
##  Max.   :21543618                                                
##  NA's   :23140                                                   
##    purpose             source         
##  Length:67161       Length:67161      
##  Class :character   Class :character  
##  Mode  :character   Mode  :character  
##                                       
##                                       
##                                       
## 
```


2. Use `naniar` to summarize the NA's in each variable.


```r
naniar::miss_var_summary(cites)
```

```
## # A tibble: 16 x 3
##    variable                   n_miss pct_miss
##    <chr>                       <int>    <dbl>
##  1 unit                        60759  90.5   
##  2 origin                      41518  61.8   
##  3 importer_reported_quantity  35295  52.6   
##  4 exporter_reported_quantity  23140  34.5   
##  5 class                       20224  30.1   
##  6 purpose                      6059   9.02  
##  7 genus                        1459   2.17  
##  8 exporter                      573   0.853 
##  9 source                        544   0.810 
## 10 family                        461   0.686 
## 11 importer                       71   0.106 
## 12 order                          57   0.0849
## 13 year                            0   0     
## 14 app                             0   0     
## 15 taxon                           0   0     
## 16 term                            0   0
```

3. Try using `group_by()` with `naniar`. Look specifically at class and `exporter_reported_quantity`. For which taxonomic classes do we have a high proportion of missing export data?


```r
cites %>% 
  select(class, exporter_reported_quantity) %>% 
  group_by(class) %>% 
  naniar::miss_var_summary() %>% 
  arrange(desc(pct_miss))
```

```
## # A tibble: 17 x 4
## # Groups:   class [17]
##    class          variable                   n_miss pct_miss
##    <chr>          <chr>                       <int>    <dbl>
##  1 Holothuroidea  exporter_reported_quantity     10    100  
##  2 Dipneusti      exporter_reported_quantity      3     75  
##  3 Bivalvia       exporter_reported_quantity    165     61.3
##  4 Gastropoda     exporter_reported_quantity    104     54.5
##  5 Elasmobranchii exporter_reported_quantity     58     51.3
##  6 Arachnida      exporter_reported_quantity     32     47.8
##  7 Amphibia       exporter_reported_quantity    190     45.2
##  8 Anthozoa       exporter_reported_quantity   3858     43.9
##  9 Mammalia       exporter_reported_quantity   3731     43.9
## 10 <NA>           exporter_reported_quantity   7002     34.6
## 11 Hydrozoa       exporter_reported_quantity     61     33.7
## 12 Hirudinoidea   exporter_reported_quantity     11     32.4
## 13 Reptilia       exporter_reported_quantity   5323     28.9
## 14 Actinopteri    exporter_reported_quantity    726     26.3
## 15 Aves           exporter_reported_quantity   1792     26.1
## 16 Insecta        exporter_reported_quantity     74     23.9
## 17 Coelacanthi    exporter_reported_quantity      0      0
```


## Visualizing NAs
There is another package `visdat` that can be used to visualize the proportion of different classes of data, including missing data. But, it is limited by size.

```r
library(visdat)
```


```r
vis_dat(life_history_tidy) #classes of data
```

![](lab7_2_files/figure-html/unnamed-chunk-21-1.png)<!-- -->


```r
vis_miss(life_history_tidy)
```

![](lab7_2_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

## Dealing with NA's in advance
If you are sure that you know how NA's are treated in the data, then you can deal with them in advance using `na()` as part of the `readr` package.

```r
life_history_advance <- 
  readr::read_csv(file = "data/mammal_lifehistories_v3.csv", 
                  na = c("NA", " ", ".", "-999")) #all NA, blank spaces, .,and -999 are treated as NA
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   order = col_character(),
##   family = col_character(),
##   Genus = col_character(),
##   species = col_character(),
##   mass = col_double(),
##   gestation = col_double(),
##   newborn = col_character(),
##   weaning = col_double(),
##   `wean mass` = col_double(),
##   AFR = col_double(),
##   `max. life` = col_double(),
##   `litter size` = col_double(),
##   `litters/year` = col_double()
## )
```

Note you would still need to deal with some variables case-by-case.

```r
naniar::miss_var_summary(life_history_advance)
```

```
## # A tibble: 13 x 3
##    variable     n_miss pct_miss
##    <chr>         <int>    <dbl>
##  1 wean mass      1039    72.2 
##  2 litters/year    689    47.8 
##  3 weaning         619    43.0 
##  4 AFR             607    42.2 
##  5 gestation       418    29.0 
##  6 mass             85     5.90
##  7 litter size      84     5.83
##  8 order             0     0   
##  9 family            0     0   
## 10 Genus             0     0   
## 11 species           0     0   
## 12 newborn           0     0   
## 13 max. life         0     0
```

## Wrap-up  
Please review the learning goals and be sure to use the code here as a reference when completing the homework.  
-->[Home](https://jmledford3115.github.io/datascibiol/)
