---
title: "RMarkdown Practice"
author: "Seona Patel"
date: "2021-01-05"
output: 
  html_document: 
    keep_md: yes
---


1. Test out the arithmetic capabilities of R; experiment by doing addition, subtraction, multiplication, and division.  

```r
4+3
```

```
## [1] 7
```

```r
5-8
```

```
## [1] -3
```

```r
7*3
```

```
## [1] 21
```

```r
4/2
```

```
## [1] 2
```


2. Go back to your "RMarkdown Practice" file and experiment with titles, text, and syntax.  

## This is my [email](mailto: seopatel@ucdavis.edu) 

## This is [Google](http://www.google.com) 
# This is my title
## This is my title 

3. Copy and paste the following two pieces of code into the document (include the gray code "chunks").

```r
#install.packages("tidyverse")
library("tidyverse")
```

```r
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
```

![](RMarkdown-Practice_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
