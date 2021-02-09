---
title: "Midterm 1"
author: "Seona Patel"
date: "2021-02-09"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  

R is a scripting language in which you write code and it does exactly what you want. RStudio is a graphical user interface that interacts with R and makes the coding experience more user-friendly. GitHub is a website used by programmers to store and manage files. It is useful because it makes it very easy and convenient for programmers to share their code and repositories. Once you have written your code in RStudio, pushing it to GitHub allows you to share what you coded with others so other people can take your code and change it or add more. The advantage of using RMarkdown in this context is that RMarkdown files allow you to format and knit together your code into a very organzied and readable file. This makes it even easier for others to understand your code and read through it quickly. 

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**

The 3 types of data structures that we have discussed are data frames, vectors, and data matrices. We are using data frames for BIS15L because it is the most common way to organize data in R and is a more readable and organized way to display data compared to a data matrix. 

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
getwd()
```

```
## [1] "/Users/Joel/Desktop/BIS15W2021_spatel/midterm 1"
```

```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, …
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00…
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M…
```

```r
summary(elephants)
```

```
##       Age            Height           Sex           
##  Min.   : 0.01   Min.   : 75.46   Length:288        
##  1st Qu.: 4.58   1st Qu.:160.75   Class :character  
##  Median : 9.46   Median :200.00   Mode  :character  
##  Mean   :10.97   Mean   :187.68                     
##  3rd Qu.:16.50   3rd Qu.:221.09                     
##  Max.   :32.17   Max.   :304.06
```

```r
anyNA(elephants)
```

```
## [1] FALSE
```

**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants <- elephants %>% 
  select_all(tolower)
elephants
```

```
## # A tibble: 288 x 3
##      age height sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # … with 278 more rows
```

```r
elephants$sex <- as.factor(elephants$sex)
class(elephants$sex)
```

```
## [1] "factor"
```

_You could also use the janitor package here to make things a bit easier._  

**5. (2 points) How many male and female elephants are represented in the data?**

There are 150 females and 138 males.

```r
elephants %>%
  group_by(sex) %>% 
  summarize(total = n())
```

```
## # A tibble: 2 x 2
##   sex   total
## * <fct> <int>
## 1 F       150
## 2 M       138
```

_Since you are doing a count, the count function is a bit cleaner_

```r
elephants %>% count(sex)
```

```
## # A tibble: 2 x 2
##   sex       n
## * <fct> <int>
## 1 F       150
## 2 M       138
```

**6. (2 points) What is the average age all elephants in the data?**

The average age of all elephants is 10.97132.

```r
elephants %>% 
  summarize(average_age = mean(age))
```

```
## # A tibble: 1 x 1
##   average_age
##         <dbl>
## 1        11.0
```

**7. (2 points) How does the average age and height of elephants compare by sex?**

Males are younger and shorter than females.

```r
elephants %>% 
  group_by(sex) %>% 
  summarize(average_age = mean(age),
            average_height = mean(height))
```

```
## # A tibble: 2 x 3
##   sex   average_age average_height
## * <fct>       <dbl>          <dbl>
## 1 F           12.8            190.
## 2 M            8.95           185.
```

**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

Males that are over 25 years old are taller on average than females over 25 years old. 

```r
elephants %>% 
  filter(age > 25) %>% 
  group_by(sex) %>% 
  summarize(average_height = mean(height),
            min_height = min(height), 
            max_height = max(height), 
            total = n())
```

```
## # A tibble: 2 x 5
##   sex   average_height min_height max_height total
## * <fct>          <dbl>      <dbl>      <dbl> <int>
## 1 F               233.       206.       278.    25
## 2 M               273.       237.       304.     8
```

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
gabon <- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

```r
glimpse(gabon)
```

```
## Rows: 24
## Columns: 26
## $ TransectID              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 16,…
## $ Distance                <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 24.0…
## $ HuntCat                 <chr> "Moderate", "None", "None", "None", "None", "…
## $ NumHouseholds           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46, 5…
## $ LandUse                 <chr> "Park", "Park", "Park", "Logging", "Park", "P…
## $ Veg_Rich                <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, 14.…
## $ Veg_Stems               <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, 31.…
## $ Veg_liana               <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.38, …
## $ Veg_DBH                 <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, 51.…
## $ Veg_Canopy              <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, 4.0…
## $ Veg_Understory          <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, 2.7…
## $ RA_Apes                 <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78, 6.…
## $ RA_Birds                <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, 42.…
## $ RA_Elephant             <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, 0.4…
## $ RA_Monkeys              <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, 46.…
## $ RA_Rodent               <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, 1.2…
## $ RA_Ungulate             <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.10, …
## $ Rich_AllSpecies         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21, 2…
## $ Evenness_AllSpecies     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, 0.8…
## $ Diversity_AllSpecies    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, 2.5…
## $ Rich_BirdSpecies        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 11, …
## $ Evenness_BirdSpecies    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, 0.8…
## $ Diversity_BirdSpecies   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, 1.9…
## $ Rich_MammalSpecies      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, 11,…
## $ Evenness_MammalSpecies  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, 0.7…
## $ Diversity_MammalSpecies <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, 1.9…
```

```r
head(gabon)
```

```
## # A tibble: 6 x 26
##   TransectID Distance HuntCat NumHouseholds LandUse Veg_Rich Veg_Stems Veg_liana
##        <dbl>    <dbl> <chr>           <dbl> <chr>      <dbl>     <dbl>     <dbl>
## 1          1     7.14 Modera…            54 Park        16.7      31.2      5.78
## 2          2    17.3  None               54 Park        15.8      37.4     13.2 
## 3          2    18.3  None               29 Park        16.9      32.3      4.75
## 4          3    20.8  None               29 Logging     12.4      29.4      9.78
## 5          4    16.0  None               29 Park        17.1      36       13.2 
## 6          5    17.5  None               29 Park        16.5      29.2     12.9 
## # … with 18 more variables: Veg_DBH <dbl>, Veg_Canopy <dbl>,
## #   Veg_Understory <dbl>, RA_Apes <dbl>, RA_Birds <dbl>, RA_Elephant <dbl>,
## #   RA_Monkeys <dbl>, RA_Rodent <dbl>, RA_Ungulate <dbl>,
## #   Rich_AllSpecies <dbl>, Evenness_AllSpecies <dbl>,
## #   Diversity_AllSpecies <dbl>, Rich_BirdSpecies <dbl>,
## #   Evenness_BirdSpecies <dbl>, Diversity_BirdSpecies <dbl>,
## #   Rich_MammalSpecies <dbl>, Evenness_MammalSpecies <dbl>,
## #   Diversity_MammalSpecies <dbl>
```

```r
gabon$HuntCat <- as.factor(gabon$HuntCat)
gabon$LandUse <- as.factor(gabon$LandUse)
class(gabon$HuntCat)
```

```
## [1] "factor"
```

```r
class(gabon$LandUse)
```

```
## [1] "factor"
```

**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

In transects with high and moderate hunting intensity, mammals are more diverse on average. 


```r
gabon %>% 
  filter(HuntCat == "Moderate" | HuntCat == "High") %>% 
  group_by(HuntCat)  %>% 
  summarize(average_bird_diversity = mean(Diversity_BirdSpecies), 
            average_mammal_diversity = mean(Diversity_MammalSpecies))
```

```
## # A tibble: 2 x 3
##   HuntCat  average_bird_diversity average_mammal_diversity
## * <fct>                     <dbl>                    <dbl>
## 1 High                       1.66                     1.74
## 2 Moderate                   1.62                     1.68
```

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

This shows that the relative abundance of apes, elephants, monkeys, and ungulates drops off in sites that are <5 km from a village compared to >20 km. The relative abundance of birds and rodents are higher in sites that are <5 km from a village compared to >20 km. 

```r
gabon %>% 
  filter(Distance < 5 | Distance > 20)  %>% 
  group_by(Distance < 5) %>% 
  summarize(across(c(RA_Apes, RA_Birds, RA_Elephant, RA_Monkeys, RA_Rodent, RA_Ungulate), mean))
```

```
## # A tibble: 2 x 7
##   `Distance < 5` RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate
## * <lgl>            <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1 FALSE             7.21     44.5      0.557        40.1      2.68        4.98
## 2 TRUE              0.08     70.4      0.0967       24.1      3.66        1.59
```
(FALSE means that the Distance is > 20 km and TRUE means that the Distance is < 5 km)

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

Which region of land use has the greatest average tree richness? 

```r
gabon %>%
  group_by(LandUse) %>% 
  summarise(average_tree_richness = mean(Veg_Rich)) %>% 
  arrange(desc(average_tree_richness))
```

```
## # A tibble: 3 x 2
##   LandUse average_tree_richness
##   <fct>                   <dbl>
## 1 Park                     16.3
## 2 Logging                  14.4
## 3 Neither                  13.5
```
The Park has the greatest average tree richness!

_Nice job Seona, I only a made a few suggestions. Keep up the good work!_
