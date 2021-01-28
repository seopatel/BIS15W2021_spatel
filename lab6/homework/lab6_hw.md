---
title: "Lab 6 Homework"
author: "Seona Patel"
date: "2021-01-27"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv('data/FAO_1950to2012_111914.csv')
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
## i Use `spec()` for the full column specifications.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  
As you can see below, the dimensions are 17,692 x 71 and there are many NA's. The classes of the variables can also be seen below. 

```r
glimpse(fisheries)
```

```
## Rows: 17,692
## Columns: 71
## $ Country                   <chr> "Albania", "Albania", "Albania", "Albania...
## $ `Common name`             <chr> "Angelsharks, sand devils nei", "Atlantic...
## $ `ISSCAAP group#`          <dbl> 38, 36, 37, 45, 32, 37, 33, 45, 38, 57, 3...
## $ `ISSCAAP taxonomic group` <chr> "Sharks, rays, chimaeras", "Tunas, bonito...
## $ `ASFIS species#`          <chr> "10903XXXXX", "1750100101", "17710001XX",...
## $ `ASFIS species name`      <chr> "Squatinidae", "Sarda sarda", "Sphyraena ...
## $ `FAO major fishing area`  <dbl> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 3...
## $ Measure                   <chr> "Quantity (tonnes)", "Quantity (tonnes)",...
## $ `1950`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1951`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1952`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1953`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1954`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1955`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1956`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1957`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1958`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1959`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1960`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1961`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1962`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1963`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1964`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1965`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1966`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1967`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1968`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1969`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1970`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1971`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1972`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1973`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1974`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1975`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1976`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1977`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1978`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1979`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1980`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1981`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1982`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
## $ `1983`                    <chr> NA, NA, NA, NA, NA, NA, "559", NA, NA, NA...
## $ `1984`                    <chr> NA, NA, NA, NA, NA, NA, "392", NA, NA, NA...
## $ `1985`                    <chr> NA, NA, NA, NA, NA, NA, "406", NA, NA, NA...
## $ `1986`                    <chr> NA, NA, NA, NA, NA, NA, "499", NA, NA, NA...
## $ `1987`                    <chr> NA, NA, NA, NA, NA, NA, "564", NA, NA, NA...
## $ `1988`                    <chr> NA, NA, NA, NA, NA, NA, "724", NA, NA, NA...
## $ `1989`                    <chr> NA, NA, NA, NA, NA, NA, "583", NA, NA, NA...
## $ `1990`                    <chr> NA, NA, NA, NA, NA, NA, "754", NA, NA, NA...
## $ `1991`                    <chr> NA, NA, NA, NA, NA, NA, "283", NA, NA, NA...
## $ `1992`                    <chr> NA, NA, NA, NA, NA, NA, "196", NA, NA, NA...
## $ `1993`                    <chr> NA, NA, NA, NA, NA, NA, "150 F", NA, NA, ...
## $ `1994`                    <chr> NA, NA, NA, NA, NA, NA, "100 F", NA, NA, ...
## $ `1995`                    <chr> "0 0", "1", NA, "0 0", "0 0", NA, "52", "...
## $ `1996`                    <chr> "53", "2", NA, "3", "2", NA, "104", "8", ...
## $ `1997`                    <chr> "20", "0 0", NA, "0 0", "0 0", NA, "65", ...
## $ `1998`                    <chr> "31", "12", NA, NA, NA, NA, "220", "18", ...
## $ `1999`                    <chr> "30", "30", NA, NA, NA, NA, "220", "18", ...
## $ `2000`                    <chr> "30", "25", "2", NA, NA, NA, "220", "20",...
## $ `2001`                    <chr> "16", "30", NA, NA, NA, NA, "120", "23", ...
## $ `2002`                    <chr> "79", "24", NA, "34", "6", NA, "150", "84...
## $ `2003`                    <chr> "1", "4", NA, "22", NA, NA, "84", "178", ...
## $ `2004`                    <chr> "4", "2", "2", "15", "1", "2", "76", "285...
## $ `2005`                    <chr> "68", "23", "4", "12", "5", "6", "68", "1...
## $ `2006`                    <chr> "55", "30", "7", "18", "8", "9", "86", "1...
## $ `2007`                    <chr> "12", "19", NA, NA, NA, NA, "132", "18", ...
## $ `2008`                    <chr> "23", "27", NA, NA, NA, NA, "132", "23", ...
## $ `2009`                    <chr> "14", "21", NA, NA, NA, NA, "154", "20", ...
## $ `2010`                    <chr> "78", "23", "7", NA, NA, NA, "80", "228",...
## $ `2011`                    <chr> "12", "12", NA, NA, NA, NA, "88", "9", NA...
## $ `2012`                    <chr> "5", "5", NA, NA, NA, NA, "129", "290", N...
```

```r
head(fisheries)
```

```
## # A tibble: 6 x 71
##   Country `Common name` `ISSCAAP group#` `ISSCAAP taxono~ `ASFIS species#`
##   <chr>   <chr>                    <dbl> <chr>            <chr>           
## 1 Albania Angelsharks,~               38 Sharks, rays, c~ 10903XXXXX      
## 2 Albania Atlantic bon~               36 Tunas, bonitos,~ 1750100101      
## 3 Albania Barracudas n~               37 Miscellaneous p~ 17710001XX      
## 4 Albania Blue and red~               45 Shrimps, prawns  2280203101      
## 5 Albania Blue whiting~               32 Cods, hakes, ha~ 1480403301      
## 6 Albania Bluefish                    37 Miscellaneous p~ 1702021301      
## # ... with 66 more variables: `ASFIS species name` <chr>, `FAO major fishing
## #   area` <dbl>, Measure <chr>, `1950` <chr>, `1951` <chr>, `1952` <chr>,
## #   `1953` <chr>, `1954` <chr>, `1955` <chr>, `1956` <chr>, `1957` <chr>,
## #   `1958` <chr>, `1959` <chr>, `1960` <chr>, `1961` <chr>, `1962` <chr>,
## #   `1963` <chr>, `1964` <chr>, `1965` <chr>, `1966` <chr>, `1967` <chr>,
## #   `1968` <chr>, `1969` <chr>, `1970` <chr>, `1971` <chr>, `1972` <chr>,
## #   `1973` <chr>, `1974` <chr>, `1975` <chr>, `1976` <chr>, `1977` <chr>,
## #   `1978` <chr>, `1979` <chr>, `1980` <chr>, `1981` <chr>, `1982` <chr>,
## #   `1983` <chr>, `1984` <chr>, `1985` <chr>, `1986` <chr>, `1987` <chr>,
## #   `1988` <chr>, `1989` <chr>, `1990` <chr>, `1991` <chr>, `1992` <chr>,
## #   `1993` <chr>, `1994` <chr>, `1995` <chr>, `1996` <chr>, `1997` <chr>,
## #   `1998` <chr>, `1999` <chr>, `2000` <chr>, `2001` <chr>, `2002` <chr>,
## #   `2003` <chr>, `2004` <chr>, `2005` <chr>, `2006` <chr>, `2007` <chr>,
## #   `2008` <chr>, `2009` <chr>, `2010` <chr>, `2011` <chr>, `2012` <chr>
```

```r
tail(fisheries)
```

```
## # A tibble: 6 x 71
##   Country `Common name` `ISSCAAP group#` `ISSCAAP taxono~ `ASFIS species#`
##   <chr>   <chr>                    <dbl> <chr>            <chr>           
## 1 Zanzib~ Seerfishes n~               36 Tunas, bonitos,~ 17501015XX      
## 2 Zanzib~ Sharks, rays~               38 Sharks, rays, c~ 199XXXXXXX054   
## 3 Zanzib~ Snappers, jo~               33 Miscellaneous c~ 17032XXXXX      
## 4 Zanzib~ Spinefeet(=R~               33 Miscellaneous c~ 17407001XX      
## 5 Zanzib~ Tropical spi~               43 Lobsters, spiny~ 22901001XX      
## 6 Zanzib~ Tunalike fis~               36 Tunas, bonitos,~ 175XXXXXXX      
## # ... with 66 more variables: `ASFIS species name` <chr>, `FAO major fishing
## #   area` <dbl>, Measure <chr>, `1950` <chr>, `1951` <chr>, `1952` <chr>,
## #   `1953` <chr>, `1954` <chr>, `1955` <chr>, `1956` <chr>, `1957` <chr>,
## #   `1958` <chr>, `1959` <chr>, `1960` <chr>, `1961` <chr>, `1962` <chr>,
## #   `1963` <chr>, `1964` <chr>, `1965` <chr>, `1966` <chr>, `1967` <chr>,
## #   `1968` <chr>, `1969` <chr>, `1970` <chr>, `1971` <chr>, `1972` <chr>,
## #   `1973` <chr>, `1974` <chr>, `1975` <chr>, `1976` <chr>, `1977` <chr>,
## #   `1978` <chr>, `1979` <chr>, `1980` <chr>, `1981` <chr>, `1982` <chr>,
## #   `1983` <chr>, `1984` <chr>, `1985` <chr>, `1986` <chr>, `1987` <chr>,
## #   `1988` <chr>, `1989` <chr>, `1990` <chr>, `1991` <chr>, `1992` <chr>,
## #   `1993` <chr>, `1994` <chr>, `1995` <chr>, `1996` <chr>, `1997` <chr>,
## #   `1998` <chr>, `1999` <chr>, `2000` <chr>, `2001` <chr>, `2002` <chr>,
## #   `2003` <chr>, `2004` <chr>, `2005` <chr>, `2006` <chr>, `2007` <chr>,
## #   `2008` <chr>, `2009` <chr>, `2010` <chr>, `2011` <chr>, `2012` <chr>
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- janitor::clean_names(fisheries)
```


```r
fisheries$country <- as.factor(fisheries$country)
fisheries$isscaap_group_number <- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area <- as.factor(fisheries$fao_major_fishing_area)
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
fisheries_tidy %>%
  summarise(distinct_countries =n_distinct(country))
```

```
## # A tibble: 1 x 1
##   distinct_countries
##                <int>
## 1                203
```


```r
levels(fisheries_tidy$country)
```

```
##   [1] "Albania"                   "Algeria"                  
##   [3] "American Samoa"            "Angola"                   
##   [5] "Anguilla"                  "Antigua and Barbuda"      
##   [7] "Argentina"                 "Aruba"                    
##   [9] "Australia"                 "Bahamas"                  
##  [11] "Bahrain"                   "Bangladesh"               
##  [13] "Barbados"                  "Belgium"                  
##  [15] "Belize"                    "Benin"                    
##  [17] "Bermuda"                   "Bonaire/S.Eustatius/Saba" 
##  [19] "Bosnia and Herzegovina"    "Brazil"                   
##  [21] "British Indian Ocean Ter"  "British Virgin Islands"   
##  [23] "Brunei Darussalam"         "Bulgaria"                 
##  [25] "C<f4>te d'Ivoire"          "Cabo Verde"               
##  [27] "Cambodia"                  "Cameroon"                 
##  [29] "Canada"                    "Cayman Islands"           
##  [31] "Channel Islands"           "Chile"                    
##  [33] "China"                     "China, Hong Kong SAR"     
##  [35] "China, Macao SAR"          "Colombia"                 
##  [37] "Comoros"                   "Congo, Dem. Rep. of the"  
##  [39] "Congo, Republic of"        "Cook Islands"             
##  [41] "Costa Rica"                "Croatia"                  
##  [43] "Cuba"                      "Cura<e7>ao"               
##  [45] "Cyprus"                    "Denmark"                  
##  [47] "Djibouti"                  "Dominica"                 
##  [49] "Dominican Republic"        "Ecuador"                  
##  [51] "Egypt"                     "El Salvador"              
##  [53] "Equatorial Guinea"         "Eritrea"                  
##  [55] "Estonia"                   "Ethiopia"                 
##  [57] "Falkland Is.(Malvinas)"    "Faroe Islands"            
##  [59] "Fiji, Republic of"         "Finland"                  
##  [61] "France"                    "French Guiana"            
##  [63] "French Polynesia"          "French Southern Terr"     
##  [65] "Gabon"                     "Gambia"                   
##  [67] "Georgia"                   "Germany"                  
##  [69] "Ghana"                     "Gibraltar"                
##  [71] "Greece"                    "Greenland"                
##  [73] "Grenada"                   "Guadeloupe"               
##  [75] "Guam"                      "Guatemala"                
##  [77] "Guinea"                    "GuineaBissau"             
##  [79] "Guyana"                    "Haiti"                    
##  [81] "Honduras"                  "Iceland"                  
##  [83] "India"                     "Indonesia"                
##  [85] "Iran (Islamic Rep. of)"    "Iraq"                     
##  [87] "Ireland"                   "Isle of Man"              
##  [89] "Israel"                    "Italy"                    
##  [91] "Jamaica"                   "Japan"                    
##  [93] "Jordan"                    "Kenya"                    
##  [95] "Kiribati"                  "Korea, Dem. People's Rep" 
##  [97] "Korea, Republic of"        "Kuwait"                   
##  [99] "Latvia"                    "Lebanon"                  
## [101] "Liberia"                   "Libya"                    
## [103] "Lithuania"                 "Madagascar"               
## [105] "Malaysia"                  "Maldives"                 
## [107] "Malta"                     "Marshall Islands"         
## [109] "Martinique"                "Mauritania"               
## [111] "Mauritius"                 "Mayotte"                  
## [113] "Mexico"                    "Micronesia, Fed.States of"
## [115] "Monaco"                    "Montenegro"               
## [117] "Montserrat"                "Morocco"                  
## [119] "Mozambique"                "Myanmar"                  
## [121] "Namibia"                   "Nauru"                    
## [123] "Netherlands"               "Netherlands Antilles"     
## [125] "New Caledonia"             "New Zealand"              
## [127] "Nicaragua"                 "Nigeria"                  
## [129] "Niue"                      "Norfolk Island"           
## [131] "Northern Mariana Is."      "Norway"                   
## [133] "Oman"                      "Other nei"                
## [135] "Pakistan"                  "Palau"                    
## [137] "Palestine, Occupied Tr."   "Panama"                   
## [139] "Papua New Guinea"          "Peru"                     
## [141] "Philippines"               "Pitcairn Islands"         
## [143] "Poland"                    "Portugal"                 
## [145] "Puerto Rico"               "Qatar"                    
## [147] "R<e9>union"                "Romania"                  
## [149] "Russian Federation"        "Saint Barth<e9>lemy"      
## [151] "Saint Helena"              "Saint Kitts and Nevis"    
## [153] "Saint Lucia"               "Saint Vincent/Grenadines" 
## [155] "SaintMartin"               "Samoa"                    
## [157] "Sao Tome and Principe"     "Saudi Arabia"             
## [159] "Senegal"                   "Serbia and Montenegro"    
## [161] "Seychelles"                "Sierra Leone"             
## [163] "Singapore"                 "Sint Maarten"             
## [165] "Slovenia"                  "Solomon Islands"          
## [167] "Somalia"                   "South Africa"             
## [169] "Spain"                     "Sri Lanka"                
## [171] "St. Pierre and Miquelon"   "Sudan"                    
## [173] "Sudan (former)"            "Suriname"                 
## [175] "Svalbard and Jan Mayen"    "Sweden"                   
## [177] "Syrian Arab Republic"      "Taiwan Province of China" 
## [179] "Tanzania, United Rep. of"  "Thailand"                 
## [181] "TimorLeste"                "Togo"                     
## [183] "Tokelau"                   "Tonga"                    
## [185] "Trinidad and Tobago"       "Tunisia"                  
## [187] "Turkey"                    "Turks and Caicos Is."     
## [189] "Tuvalu"                    "Ukraine"                  
## [191] "Un. Sov. Soc. Rep."        "United Arab Emirates"     
## [193] "United Kingdom"            "United States of America" 
## [195] "Uruguay"                   "US Virgin Islands"        
## [197] "Vanuatu"                   "Venezuela, Boliv Rep of"  
## [199] "Viet Nam"                  "Wallis and Futuna Is."    
## [201] "Western Sahara"            "Yemen"                    
## [203] "Yugoslavia SFR"            "Zanzibar"
```

4. Refocus the data only to include only: country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
names(fisheries_tidy)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "year"                    "catch"
```


```r
fisheries_tidy_focused <- fisheries_tidy %>% 
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch) 
fisheries_tidy_focused
```

```
## # A tibble: 376,771 x 6
##    country isscaap_taxonomic_g~ asfis_species_na~ asfis_species_num~  year catch
##    <fct>   <chr>                <chr>             <fct>              <dbl> <dbl>
##  1 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1995    NA
##  2 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1996    53
##  3 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1997    20
##  4 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1998    31
##  5 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1999    30
##  6 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2000    30
##  7 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2001    16
##  8 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2002    79
##  9 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2003     1
## 10 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2004     4
## # ... with 376,761 more rows
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?
**1551 distinct species**

```r
fisheries_tidy_focused %>% 
  summarize(distinct_species <- n_distinct(asfis_species_number))
```

```
## # A tibble: 1 x 1
##   `distinct_species <- n_distinct(asfis_species_number)`
##                                                    <int>
## 1                                                   1551
```

6. Which country had the largest overall catch in the year 2000?
**China had the largest overall catch in 2000.**

```r
fisheries_tidy_focused %>% 
  filter(year == 2000) %>% 
  group_by(country) %>% 
  summarize(catch_total = sum(catch, na.rm=T)) %>% 
  arrange(desc(catch_total))
```

```
## # A tibble: 193 x 2
##    country                  catch_total
##    <fct>                          <dbl>
##  1 China                          25899
##  2 Russian Federation             12181
##  3 United States of America       11762
##  4 Japan                           8510
##  5 Indonesia                       8341
##  6 Peru                            7443
##  7 Chile                           6906
##  8 India                           6351
##  9 Thailand                        6243
## 10 Korea, Republic of              6124
## # ... with 183 more rows
```

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?
**Morocco caught the most sardines between 1990-2000.**

```r
fisheries_tidy_focused %>% 
  filter(asfis_species_name == "Sardina pilchardus") %>% 
  filter(between(year, 1990, 2000)) %>% 
  group_by(country) %>% 
  summarize(catch_sum = sum(catch, na.rm=T)) %>% 
  arrange(desc(catch_sum))
```

```
## # A tibble: 37 x 2
##    country               catch_sum
##    <fct>                     <dbl>
##  1 Morocco                    7470
##  2 Spain                      3507
##  3 Russian Federation         1639
##  4 Ukraine                    1030
##  5 France                      966
##  6 Portugal                    818
##  7 Greece                      528
##  8 Italy                       507
##  9 Serbia and Montenegro       478
## 10 Denmark                     477
## # ... with 27 more rows
```


8. Which five countries caught the most cephalopods between 2008-2012?
**China, The Republic of Korea, Peru, Japan, Chile**

```r
fisheries_tidy_focused %>% 
  filter(isscaap_taxonomic_group == "Squids, cuttlefishes, octopuses") %>% 
  filter(between(year, 2008, 2012)) %>% 
  group_by(country) %>% 
  summarize(total_catch = sum(catch, na.rm=T)) %>% 
  arrange(desc(total_catch))
```

```
## # A tibble: 122 x 2
##    country                  total_catch
##    <fct>                          <dbl>
##  1 China                           8349
##  2 Korea, Republic of              3480
##  3 Peru                            3422
##  4 Japan                           3248
##  5 Chile                           2775
##  6 United States of America        2417
##  7 Indonesia                       1622
##  8 Taiwan Province of China        1394
##  9 Spain                           1147
## 10 France                          1138
## # ... with 112 more rows
```

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)
**Theragra chalcogramma had the highest catch total between 2008-2012.** 

```r
fisheries_tidy_focused %>% 
  filter(between(year, 2008, 2012)) %>% 
  group_by(asfis_species_name) %>% 
  summarise(total_catch = sum(catch, na.rm=T)) %>% 
  arrange(desc(total_catch))
```

```
## # A tibble: 1,472 x 2
##    asfis_species_name    total_catch
##    <chr>                       <dbl>
##  1 Osteichthyes               107808
##  2 Theragra chalcogramma       41075
##  3 Engraulis ringens           35523
##  4 Katsuwonus pelamis          32153
##  5 Trichiurus lepturus         30400
##  6 Clupea harengus             28527
##  7 Thunnus albacares           20119
##  8 Scomber japonicus           14723
##  9 Gadus morhua                13253
## 10 Thunnus alalunga            12019
## # ... with 1,462 more rows
```

10. Use the data to do at least one analysis of your choice.

```r
# Which species of fish did the US catch the most in total?

fisheries_tidy_focused %>% 
  filter(country == "United States of America") %>% 
  group_by(asfis_species_name) %>% 
  summarize(total_catch = sum(catch, na.rm=T)) %>% 
  arrange(desc(total_catch))
```

```
## # A tibble: 373 x 2
##    asfis_species_name       total_catch
##    <chr>                          <dbl>
##  1 Theragra chalcogramma         134724
##  2 Brevoortia patronus            32931
##  3 Brevoortia tyrannus            31517
##  4 Spisula solidissima            24610
##  5 Crassostrea virginica          19891
##  6 Arctica islandica              19305
##  7 Gadus macrocephalus            16013
##  8 Oncorhynchus gorbuscha         14463
##  9 Placopecten magellanicus       13957
## 10 Oncorhynchus nerka             13115
## # ... with 363 more rows
```
**Theragra chalcogramma is the answer once again. **

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
