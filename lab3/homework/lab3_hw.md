---
title: "Lab 3 Homework"
author: "Seona Patel"
date: "2021-01-12"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Mammals Sleep
1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R.

V. M. Savage and G. B. West. A quantitative, theoretical framework for understanding mammalian sleep. Proceedings of the National Academy of Sciences, 104 (3):1051-1056, 2007

```r
?msleep
```

2. Store these data into a new data frame `sleep`.

```r
sleep <- msleep
```

3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.  

83 observations of 11 variables

```r
dim(sleep)
```

```
## [1] 83 11
```

4. Are there any NAs in the data? How did you determine this? Please show your code. 

Yes, there are some NAs in vore, conservation, sleep_rem, sleep_cycle, brainwt, etc. I figured this out by using the `glimpse()` function.

```r
glimpse(sleep)
```

```
## Rows: 83
## Columns: 11
## $ name         <chr> "Cheetah", "Owl monkey", "Mountain beaver", "Greater sho…
## $ genus        <chr> "Acinonyx", "Aotus", "Aplodontia", "Blarina", "Bos", "Br…
## $ vore         <chr> "carni", "omni", "herbi", "omni", "herbi", "herbi", "car…
## $ order        <chr> "Carnivora", "Primates", "Rodentia", "Soricomorpha", "Ar…
## $ conservation <chr> "lc", NA, "nt", "lc", "domesticated", NA, "vu", NA, "dom…
## $ sleep_total  <dbl> 12.1, 17.0, 14.4, 14.9, 4.0, 14.4, 8.7, 7.0, 10.1, 3.0, …
## $ sleep_rem    <dbl> NA, 1.8, 2.4, 2.3, 0.7, 2.2, 1.4, NA, 2.9, NA, 0.6, 0.8,…
## $ sleep_cycle  <dbl> NA, NA, NA, 0.1333333, 0.6666667, 0.7666667, 0.3833333, …
## $ awake        <dbl> 11.9, 7.0, 9.6, 9.1, 20.0, 9.6, 15.3, 17.0, 13.9, 21.0, …
## $ brainwt      <dbl> NA, 0.01550, NA, 0.00029, 0.42300, NA, NA, NA, 0.07000, …
## $ bodywt       <dbl> 50.000, 0.480, 1.350, 0.019, 600.000, 3.850, 20.490, 0.0…
```

5. Show a list of the column names is this data frame.

```r
names(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

6. How many herbivores are represented in the data?  

There are 32 herbivores in the data. 

```r
table(sleep$vore)
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```

7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 1kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.

```r
names(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```


```r
small <- subset(sleep, bodywt<= 1)
small
```

```
## # A tibble: 36 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Owl … Aotus omni  Prim… <NA>                17         1.8      NA       7  
##  2 Grea… Blar… omni  Sori… lc                  14.9       2.3       0.133   9.1
##  3 Vesp… Calo… <NA>  Rode… <NA>                 7        NA        NA      17  
##  4 Guin… Cavis herbi Rode… domesticated         9.4       0.8       0.217  14.6
##  5 Chin… Chin… herbi Rode… domesticated        12.5       1.5       0.117  11.5
##  6 Star… Cond… omni  Sori… lc                  10.3       2.2      NA      13.7
##  7 Afri… Cric… omni  Rode… <NA>                 8.3       2        NA      15.7
##  8 Less… Cryp… omni  Sori… lc                   9.1       1.4       0.15   14.9
##  9 Big … Epte… inse… Chir… lc                  19.7       3.9       0.117   4.3
## 10 Euro… Erin… omni  Erin… lc                  10.1       3.5       0.283  13.9
## # … with 26 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

```r
large <- subset(sleep, bodywt >= 200)
large
```

```
## # A tibble: 7 x 11
##   name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Cow   Bos   herbi Arti… domesticated         4         0.7       0.667  20  
## 2 Asia… Elep… herbi Prob… en                   3.9      NA        NA      20.1
## 3 Horse Equus herbi Peri… domesticated         2.9       0.6       1      21.1
## 4 Gira… Gira… herbi Arti… cd                   1.9       0.4      NA      22.1
## 5 Pilo… Glob… carni Ceta… cd                   2.7       0.1      NA      21.4
## 6 Afri… Loxo… herbi Prob… vu                   3.3      NA        NA      20.7
## 7 Braz… Tapi… herbi Peri… vu                   4.4       1         0.9    19.6
## # … with 2 more variables: brainwt <dbl>, bodywt <dbl>
```

8. What is the mean weight for both the small and large mammals?

```r
small_weights <- small$bodywt
small_weights
```

```
##  [1] 0.480 0.019 0.045 0.728 0.420 0.060 1.000 0.005 0.023 0.770 0.071 0.200
## [13] 0.370 0.053 0.120 0.035 0.022 0.010 0.266 0.210 0.028 0.550 0.021 0.320
## [25] 0.044 0.743 0.075 0.148 0.122 0.920 0.101 0.205 0.048 0.112 0.900 0.104
```
Find the mean of small mammals:

```r
mean(small_weights)
```

```
## [1] 0.2596667
```


```r
large_weights <- large$bodywt
large_weights
```

```
## [1]  600.000 2547.000  521.000  899.995  800.000 6654.000  207.501
```
Find the mean of large mammals:

```r
mean(large_weights)
```

```
## [1] 1747.071
```

9. Using a similar approach as above, do large or small animals sleep longer on average?  

On average, small animals sleep for 12.65833 hours while large animals sleep for 3.3 hours total. This means the small animals sleep longer on average. 

```r
small_sleep_total <- small$sleep_total
small_sleep_total 
```

```
##  [1] 17.0 14.9  7.0  9.4 12.5 10.3  8.3  9.1 19.7 10.1 14.9  9.8 19.4 14.2 14.3
## [16] 12.8 12.5 19.9 14.6  7.7 14.5 10.3 11.5 13.0  8.7  9.6  8.4 11.3 10.6 16.6
## [31] 13.8 15.9 12.8 15.8 15.6  8.9
```

```r
mean(small_sleep_total)
```

```
## [1] 12.65833
```



```r
large_sleep_total <- large$sleep_total
large_sleep_total
```

```
## [1] 4.0 3.9 2.9 1.9 2.7 3.3 4.4
```

```r
mean(large_sleep_total)
```

```
## [1] 3.3
```


10. Which animal is the sleepiest among the entire data frame?

I will consider "sleepiest" as meaning which animal sleeps the longest.

Based on the code below, the Little Brown Bat is the sleepiest among the entire data frame.

```r
max(sleep$sleep_total)
```

```
## [1] 19.9
```


```r
sleepiest <- subset(sleep, sleep_total == 19.9)
sleepiest[1]
```

```
## # A tibble: 1 x 1
##   name            
##   <chr>           
## 1 Little brown bat
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
